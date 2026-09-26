import '/components/nav_item/nav_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bottom_nav_child4_model.dart';
export 'bottom_nav_child4_model.dart';

class BottomNavChild4Widget extends StatefulWidget {
  const BottomNavChild4Widget({super.key});

  @override
  State<BottomNavChild4Widget> createState() => _BottomNavChild4WidgetState();
}

class _BottomNavChild4WidgetState extends State<BottomNavChild4Widget> {
  late BottomNavChild4Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomNavChild4Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        wrapWithModel(
          model: _model.navItemModel1,
          updateCallback: () => safeSetState(() {}),
          child: NavItemWidget(
            label: 'РАБОТА',
            icon: Icon(
              Icons.map_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            target: 'WorkMain',
            selected: false,
          ),
        ),
        wrapWithModel(
          model: _model.navItemModel2,
          updateCallback: () => safeSetState(() {}),
          child: NavItemWidget(
            label: 'ЗАКАЗЫ',
            icon: Icon(
              Icons.list_alt_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            target: 'OrderList',
            selected: false,
          ),
        ),
        wrapWithModel(
          model: _model.navItemModel3,
          updateCallback: () => safeSetState(() {}),
          child: NavItemWidget(
            label: 'НОВОСТИ',
            icon: Icon(
              Icons.campaign_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            target: 'News',
            selected: false,
          ),
        ),
        wrapWithModel(
          model: _model.navItemModel4,
          updateCallback: () => safeSetState(() {}),
          child: NavItemWidget(
            label: 'ЧАТ',
            icon: Icon(
              Icons.chat_bubble_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            target: 'ChatSupport',
            selected: true,
          ),
        ),
        wrapWithModel(
          model: _model.navItemModel5,
          updateCallback: () => safeSetState(() {}),
          child: NavItemWidget(
            label: 'ПРОФИЛЬ',
            icon: Icon(
              Icons.person_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            target: 'MasterProfile',
            selected: false,
          ),
        ),
      ],
    );
  }
}
