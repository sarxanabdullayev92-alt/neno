import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'photo_slot_model.dart';
export 'photo_slot_model.dart';

class PhotoSlotWidget extends StatefulWidget {
  const PhotoSlotWidget({
    super.key,
    bool? isEmpty,
  }) : this.isEmpty = isEmpty ?? false;

  final bool isEmpty;

  @override
  State<PhotoSlotWidget> createState() => _PhotoSlotWidgetState();
}

class _PhotoSlotWidgetState extends State<PhotoSlotWidget> {
  late PhotoSlotModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhotoSlotModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: valueOrDefault<Color>(
              valueOrDefault<bool>(
                widget!.isEmpty,
                false,
              )
                  ? FlutterFlowTheme.of(context).alternate
                  : Colors.transparent,
              Colors.transparent,
            ),
            width: valueOrDefault<double>(
              valueOrDefault<bool>(
                widget!.isEmpty,
                false,
              )
                  ? 1.0
                  : 1.0,
              1.0,
            ),
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional(-1.0, -1.0),
          children: [
            Container(
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  valueOrDefault<bool>(
                    widget!.isEmpty,
                    false,
                  )
                      ? FlutterFlowTheme.of(context).secondaryBackground
                      : Colors.transparent,
                  Colors.transparent,
                ),
                shape: BoxShape.rectangle,
              ),
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 28.0,
                  ),
                  CachedNetworkImage(
                    fadeInDuration: Duration(milliseconds: 0),
                    fadeOutDuration: Duration(milliseconds: 0),
                    imageUrl:
                        'https://dimg.dreamflow.cloud/v1/image/furniture%20stain%20or%20detail',
                    fit: BoxFit.cover,
                    alignment: Alignment(0.0, 0.0),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(1.0, -1.0),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: FlutterFlowIconButton(
                      borderRadius: 9999.0,
                      buttonSize: 40.0,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: FlutterFlowTheme.of(context).error,
                        size: 18.0,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
