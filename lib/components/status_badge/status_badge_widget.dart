import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'status_badge_model.dart';
export 'status_badge_model.dart';

class StatusBadgeWidget extends StatefulWidget {
  const StatusBadgeWidget({
    super.key,
    String? label,
    Color? tone,
  })  : this.label = label ?? 'Назначен',
        this.tone = tone ?? const Color(0x00000000);

  final String label;
  final Color tone;

  @override
  State<StatusBadgeWidget> createState() => _StatusBadgeWidgetState();
}

class _StatusBadgeWidgetState extends State<StatusBadgeWidget> {
  late StatusBadgeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StatusBadgeModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: valueOrDefault<Color>(
          widget!.tone,
          FlutterFlowTheme.of(context).success,
        ),
        shape: BoxShape.rectangle,
      ),
      child: Text(
        valueOrDefault<String>(
          widget!.label,
          'Назначен',
        ),
        style: FlutterFlowTheme.of(context).labelLarge.override(
              font: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
              ),
              color: valueOrDefault<Color>(
                widget!.tone,
                FlutterFlowTheme.of(context).success,
              ),
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
              lineHeight: 1.3,
            ),
      ),
    );
  }
}
