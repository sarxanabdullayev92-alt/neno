import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'transaction_row_model.dart';
export 'transaction_row_model.dart';

class TransactionRowWidget extends StatefulWidget {
  const TransactionRowWidget({
    super.key,
    String? amount,
    String? label,
    String? time,
    bool? isIncome,
  })  : this.amount = amount ?? '- 5 000 ₽',
        this.label = label ?? 'Выплата на карту **** 4412',
        this.time = time ?? 'Сегодня, 10:15',
        this.isIncome = isIncome ?? false;

  final String amount;
  final String label;
  final String time;
  final bool isIncome;

  @override
  State<TransactionRowWidget> createState() => _TransactionRowWidgetState();
}

class _TransactionRowWidgetState extends State<TransactionRowWidget> {
  late TransactionRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TransactionRowModel());
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
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 32.0,
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: valueOrDefault<Color>(
                        valueOrDefault<bool>(
                          widget!.isIncome,
                          false,
                        )
                            ? FlutterFlowTheme.of(context).success10
                            : FlutterFlowTheme.of(context).surfaceVariant,
                        FlutterFlowTheme.of(context).surfaceVariant,
                      ),
                      borderRadius: BorderRadius.circular(2.0),
                      shape: BoxShape.rectangle,
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: 16.0,
                      height: 16.0,
                      child: Stack(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        children: [
                          Icon(
                            Icons.add_rounded,
                            color: valueOrDefault<Color>(
                              valueOrDefault<bool>(
                                widget!.isIncome,
                                false,
                              )
                                  ? FlutterFlowTheme.of(context).success
                                  : FlutterFlowTheme.of(context).secondaryText,
                              FlutterFlowTheme.of(context).secondaryText,
                            ),
                            size: 16.0,
                          ),
                          Icon(
                            Icons.remove_rounded,
                            color: valueOrDefault<Color>(
                              valueOrDefault<bool>(
                                widget!.isIncome,
                                false,
                              )
                                  ? FlutterFlowTheme.of(context).success
                                  : FlutterFlowTheme.of(context).secondaryText,
                              FlutterFlowTheme.of(context).secondaryText,
                            ),
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          valueOrDefault<String>(
                            widget!.label,
                            'Выплата на карту **** 4412',
                          ),
                          maxLines: 1,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                                lineHeight: 1.4,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          valueOrDefault<String>(
                            widget!.time,
                            'Сегодня, 10:15',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelSmall
                              .override(
                                font: GoogleFonts.notoSansJp(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
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
                  Text(
                    valueOrDefault<String>(
                      widget!.amount,
                      '- 5 000 ₽',
                    ),
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.notoSansJp(
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                          ),
                          color: valueOrDefault<Color>(
                            valueOrDefault<bool>(
                              widget!.isIncome,
                              false,
                            )
                                ? FlutterFlowTheme.of(context).success
                                : FlutterFlowTheme.of(context).primaryText,
                            FlutterFlowTheme.of(context).primaryText,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                          lineHeight: 1.2,
                        ),
                  ),
                ].divide(SizedBox(width: 8.0)),
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
    );
  }
}
