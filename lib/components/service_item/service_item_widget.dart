import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'service_item_model.dart';
export 'service_item_model.dart';

class ServiceItemWidget extends StatefulWidget {
  const ServiceItemWidget({
    super.key,
    String? price,
    double? qty,
    String? title,
    Color? bGcolour,
    this.cancelButton,
  })  : this.price = price ?? '2 000 ₽',
        this.qty = qty ?? 2.0,
        this.title = title ?? 'Прямой диван 2-местный',
        this.bGcolour = bGcolour ?? Colors.white;

  final String price;
  final double qty;
  final String title;
  final Color bGcolour;
  final bool? cancelButton;

  @override
  State<ServiceItemWidget> createState() => _ServiceItemWidgetState();
}

class _ServiceItemWidgetState extends State<ServiceItemWidget> {
  late ServiceItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ServiceItemModel());
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
        color: widget!.bGcolour,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
        ),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          FFAppState().addToGeneralListOfService(widget!.title);
          safeSetState(() {});
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget!.cancelButton == true)
                    Flexible(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 12.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            FFAppState()
                                .addToGeneralListOfService(widget!.title);
                            safeSetState(() {});
                          },
                          child: Icon(
                            Icons.cancel_rounded,
                            color: Color(0xFFFF0101),
                            size: 28.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                valueOrDefault<String>(
                                  widget!.title,
                                  'Прямой диван 2-местный',
                                ),
                                maxLines: 2,
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                      lineHeight: 1.5,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ].divide(SizedBox(height: 4.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 1.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).alternate,
                shape: BoxShape.rectangle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
