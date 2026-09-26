import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'rating_star_model.dart';
export 'rating_star_model.dart';

class RatingStarWidget extends StatefulWidget {
  const RatingStarWidget({
    super.key,
    double? value,
    bool? active,
  })  : this.value = value ?? 1.0,
        this.active = active ?? true;

  final double value;
  final bool active;

  @override
  State<RatingStarWidget> createState() => _RatingStarWidgetState();
}

class _RatingStarWidgetState extends State<RatingStarWidget> {
  late RatingStarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RatingStarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterFlowIconButton(
      borderRadius: 8.0,
      buttonSize: 56.0,
      fillColor: Colors.transparent,
      icon: Icon(
        Icons.star_rounded,
        color: valueOrDefault<Color>(
          valueOrDefault<bool>(
            widget!.active,
            true,
          )
              ? FlutterFlowTheme.of(context).warning
              : FlutterFlowTheme.of(context).alternate,
          FlutterFlowTheme.of(context).warning,
        ),
        size: 40.0,
      ),
      onPressed: () {
        print('IconButton pressed ...');
      },
    );
  }
}
