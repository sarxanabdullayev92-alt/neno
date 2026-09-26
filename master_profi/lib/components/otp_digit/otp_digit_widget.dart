import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'otp_digit_model.dart';
export 'otp_digit_model.dart';

class OtpDigitWidget extends StatefulWidget {
  const OtpDigitWidget({
    super.key,
    String? value,
  }) : this.value = value ?? '4';

  final String value;

  @override
  State<OtpDigitWidget> createState() => _OtpDigitWidgetState();
}

class _OtpDigitWidgetState extends State<OtpDigitWidget> {
  late OtpDigitModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OtpDigitModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52.0,
      height: 64.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(0.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary,
          width: 2.0,
        ),
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Text(
        valueOrDefault<String>(
          widget!.value,
          '4',
        ),
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              font: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
              ),
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 32.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
              lineHeight: 1.4,
            ),
      ),
    );
  }
}
