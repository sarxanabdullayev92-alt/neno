import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'service_item2_model.dart';
export 'service_item2_model.dart';

class ServiceItem2Widget extends StatefulWidget {
  const ServiceItem2Widget({
    super.key,
    String? price,
    String? title,
    bool? isSelected,
  })  : this.price = price ?? '350 ₽',
        this.title = title ?? 'Стул (без спинки)',
        this.isSelected = isSelected ?? false;

  final String price;
  final String title;
  final bool isSelected;

  @override
  State<ServiceItem2Widget> createState() => _ServiceItem2WidgetState();
}

class _ServiceItem2WidgetState extends State<ServiceItem2Widget> {
  late ServiceItem2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ServiceItem2Model());
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
        color: FlutterFlowTheme.of(context).secondaryBackground,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: valueOrDefault<Color>(
            valueOrDefault<bool>(
              widget!.isSelected,
              false,
            )
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).alternate,
            FlutterFlowTheme.of(context).alternate,
          ),
          width: valueOrDefault<double>(
            valueOrDefault<bool>(
              widget!.isSelected,
              false,
            )
                ? 1.0
                : 1.0,
            1.0,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8.0, 12.0, 8.0, 12.0),
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
                    Text(
                      valueOrDefault<String>(
                        widget!.title,
                        'Стул (без спинки)',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                            lineHeight: 1.4,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget!.price,
                        '350 ₽',
                      ),
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            font: GoogleFonts.notoSansJp(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontStyle,
                            lineHeight: 1.1,
                          ),
                    ),
                  ].divide(SizedBox(height: 2.0)),
                ),
              ),
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: valueOrDefault<Color>(
                      valueOrDefault<bool>(
                        widget!.isSelected,
                        false,
                      )
                          ? FlutterFlowTheme.of(context).primary
                          : FlutterFlowTheme.of(context).alternate,
                      FlutterFlowTheme.of(context).alternate,
                    ),
                    width: valueOrDefault<double>(
                      valueOrDefault<bool>(
                        widget!.isSelected,
                        false,
                      )
                          ? 2.0
                          : 2.0,
                      2.0,
                    ),
                  ),
                ),
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Icon(
                  Icons.check_rounded,
                  color: valueOrDefault<Color>(
                    valueOrDefault<bool>(
                      widget!.isSelected,
                      false,
                    )
                        ? FlutterFlowTheme.of(context).primary
                        : Colors.transparent,
                    Colors.transparent,
                  ),
                  size: 18.0,
                ),
              ),
            ].divide(SizedBox(width: 8.0)),
          ),
        ),
      ),
    );
  }
}
