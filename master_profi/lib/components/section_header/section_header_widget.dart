import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'section_header_model.dart';
export 'section_header_model.dart';

class SectionHeaderWidget extends StatefulWidget {
  const SectionHeaderWidget({
    super.key,
    String? title,
  }) : this.title = title ?? 'ДЕНЬГИ';

  final String title;

  @override
  State<SectionHeaderWidget> createState() => _SectionHeaderWidgetState();
}

class _SectionHeaderWidgetState extends State<SectionHeaderWidget> {
  late SectionHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionHeaderModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 8.0, 4.0),
        child: Container(
          child: Text(
            valueOrDefault<String>(
              widget!.title,
              'ДЕНЬГИ',
            ),
            style: FlutterFlowTheme.of(context).labelSmall.override(
                  font: GoogleFonts.notoSansJp(
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  lineHeight: 1.1,
                ),
          ),
        ),
      ),
    );
  }
}
