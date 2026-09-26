import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'order_status_badge_model.dart';
export 'order_status_badge_model.dart';

class OrderStatusBadgeWidget extends StatefulWidget {
  const OrderStatusBadgeWidget({
    super.key,
    String? label,
    Color? tone,
  })  : this.label = label ?? 'SlotValue(\$status)',
        this.tone = tone ?? const Color(0x00000000);

  final String label;
  final Color tone;

  @override
  State<OrderStatusBadgeWidget> createState() => _OrderStatusBadgeWidgetState();
}

class _OrderStatusBadgeWidgetState extends State<OrderStatusBadgeWidget> {
  late OrderStatusBadgeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrderStatusBadgeModel());
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
          Color(0x00000000),
        ),
        shape: BoxShape.rectangle,
      ),
      child: Text(
        valueOrDefault<String>(
          widget!.label,
          'SlotValue(\$status)',
        ),
        style: FlutterFlowTheme.of(context).labelSmall.override(
              font: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
              ),
              color: valueOrDefault<Color>(
                widget!.tone,
                Color(0x00000000),
              ),
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
              lineHeight: 1.2,
            ),
      ),
    );
  }
}
