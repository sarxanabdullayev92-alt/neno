import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'diagnostic_item_model.dart';
export 'diagnostic_item_model.dart';

class DiagnosticItemWidget extends StatefulWidget {
  const DiagnosticItemWidget({
    super.key,
    String? label,
    bool? ok,
  })  : this.label = label ?? 'GPS',
        this.ok = ok ?? true;

  final String label;
  final bool ok;

  @override
  State<DiagnosticItemWidget> createState() => _DiagnosticItemWidgetState();
}

class _DiagnosticItemWidgetState extends State<DiagnosticItemWidget> {
  late DiagnosticItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DiagnosticItemModel());
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
          valueOrDefault<bool>(
            widget!.ok,
            true,
          )
              ? FlutterFlowTheme.of(context).secondary
              : Color(0xFFFFEBEE),
          FlutterFlowTheme.of(context).secondary,
        ),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                valueOrDefault<String>(
                  widget!.label,
                  'GPS',
                ),
                style: FlutterFlowTheme.of(context).labelSmall.override(
                      font: GoogleFonts.notoSansJp(
                        fontWeight:
                            FlutterFlowTheme.of(context).labelSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelSmall.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primary,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).labelSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelSmall.fontStyle,
                      lineHeight: 1.1,
                    ),
              ),
              Container(
                width: 14.0,
                height: 14.0,
                child: Stack(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: valueOrDefault<Color>(
                        valueOrDefault<bool>(
                          widget!.ok,
                          true,
                        )
                            ? FlutterFlowTheme.of(context).success
                            : FlutterFlowTheme.of(context).error,
                        FlutterFlowTheme.of(context).success,
                      ),
                      size: 14.0,
                    ),
                    Icon(
                      Icons.cancel_rounded,
                      color: valueOrDefault<Color>(
                        valueOrDefault<bool>(
                          widget!.ok,
                          true,
                        )
                            ? FlutterFlowTheme.of(context).success
                            : FlutterFlowTheme.of(context).error,
                        FlutterFlowTheme.of(context).success,
                      ),
                      size: 14.0,
                    ),
                  ],
                ),
              ),
            ].divide(SizedBox(width: 4.0)),
          ),
        ),
      ),
    );
  }
}
