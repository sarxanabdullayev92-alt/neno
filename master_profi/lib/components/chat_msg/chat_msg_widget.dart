import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_msg_model.dart';
export 'chat_msg_model.dart';

class ChatMsgWidget extends StatefulWidget {
  const ChatMsgWidget({
    super.key,
    String? text,
    String? time,
    bool? isMaster,
  })  : this.text = text ?? 'Здравствуйте! Я буду у вас через 15 минут.',
        this.time = time ?? '12:10',
        this.isMaster = isMaster ?? true;

  final String text;
  final String time;
  final bool isMaster;

  @override
  State<ChatMsgWidget> createState() => _ChatMsgWidgetState();
}

class _ChatMsgWidgetState extends State<ChatMsgWidget> {
  late ChatMsgModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatMsgModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 300.0,
          ),
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              valueOrDefault<bool>(
                widget!.isMaster,
                true,
              )
                  ? FlutterFlowTheme.of(context).primary
                  : FlutterFlowTheme.of(context).secondary,
              FlutterFlowTheme.of(context).primary,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(valueOrDefault<double>(
                valueOrDefault<bool>(
                  widget!.isMaster,
                  true,
                )
                    ? 2.0
                    : 2.0,
                2.0,
              )),
              topRight: Radius.circular(valueOrDefault<double>(
                valueOrDefault<bool>(
                  widget!.isMaster,
                  true,
                )
                    ? 2.0
                    : 2.0,
                2.0,
              )),
              bottomLeft: Radius.circular(valueOrDefault<double>(
                valueOrDefault<bool>(
                  widget!.isMaster,
                  true,
                )
                    ? 2.0
                    : 0.0,
                2.0,
              )),
              bottomRight: Radius.circular(valueOrDefault<double>(
                valueOrDefault<bool>(
                  widget!.isMaster,
                  true,
                )
                    ? 0.0
                    : 2.0,
                0.0,
              )),
            ),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: FlutterFlowTheme.of(context).primary,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget!.text,
                      'Здравствуйте! Я буду у вас через 15 минут.',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: valueOrDefault<Color>(
                            valueOrDefault<bool>(
                              widget!.isMaster,
                              true,
                            )
                                ? FlutterFlowTheme.of(context).onPrimary
                                : FlutterFlowTheme.of(context).primary,
                            FlutterFlowTheme.of(context).onPrimary,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          lineHeight: 1.4,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget!.time,
                      '12:10',
                    ),
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                          font: GoogleFonts.notoSansJp(
                            fontWeight: FontWeight.normal,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontStyle,
                          ),
                          color: valueOrDefault<Color>(
                            valueOrDefault<bool>(
                              widget!.isMaster,
                              true,
                            )
                                ? FlutterFlowTheme.of(context).onPrimary70
                                : FlutterFlowTheme.of(context).primary60,
                            FlutterFlowTheme.of(context).onPrimary70,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelSmall.fontStyle,
                          lineHeight: 1.1,
                        ),
                  ),
                ].divide(SizedBox(height: 2.0)),
              ),
            ),
          ),
        ),
      ].divide(SizedBox(width: 4.0)),
    );
  }
}
