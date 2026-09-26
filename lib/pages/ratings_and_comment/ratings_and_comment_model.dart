import '/components/button/button_widget.dart';
import '/components/rating_star/rating_star_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'ratings_and_comment_widget.dart' show RatingsAndCommentWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RatingsAndCommentModel extends FlutterFlowModel<RatingsAndCommentWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for RatingStar.
  late RatingStarModel ratingStarModel1;
  // Model for RatingStar.
  late RatingStarModel ratingStarModel2;
  // Model for RatingStar.
  late RatingStarModel ratingStarModel3;
  // Model for RatingStar.
  late RatingStarModel ratingStarModel4;
  // Model for RatingStar.
  late RatingStarModel ratingStarModel5;
  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    ratingStarModel1 = createModel(context, () => RatingStarModel());
    ratingStarModel2 = createModel(context, () => RatingStarModel());
    ratingStarModel3 = createModel(context, () => RatingStarModel());
    ratingStarModel4 = createModel(context, () => RatingStarModel());
    ratingStarModel5 = createModel(context, () => RatingStarModel());
    textFieldModel = createModel(context, () => TextFieldModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    ratingStarModel1.dispose();
    ratingStarModel2.dispose();
    ratingStarModel3.dispose();
    ratingStarModel4.dispose();
    ratingStarModel5.dispose();
    textFieldModel.dispose();
    buttonModel.dispose();
  }
}
