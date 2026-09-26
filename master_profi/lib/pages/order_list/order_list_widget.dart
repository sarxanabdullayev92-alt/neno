import '/components/bottom_nav/bottom_nav_widget.dart';
import '/components/bottom_nav_child/bottom_nav_child_widget.dart';
import '/components/order_item/order_item_widget.dart';
import '/components/tab_item/tab_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'order_list_model.dart';
export 'order_list_model.dart';

class OrderListWidget extends StatefulWidget {
  const OrderListWidget({super.key});

  static String routeName = 'OrderList';
  static String routePath = '/orderList';

  @override
  State<OrderListWidget> createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderListWidget> {
  late OrderListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrderListModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 8.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'ЗАКАЗЫ',
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.notoSansJp(
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).onPrimary,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                  lineHeight: 1.2,
                                ),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.tune_rounded,
                              color: FlutterFlowTheme.of(context).onPrimary,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: wrapWithModel(
                              model: _model.tabItemModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: TabItemWidget(
                                label: 'МОИ',
                                selected: true,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: wrapWithModel(
                              model: _model.tabItemModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: TabItemWidget(
                                label: 'СВОБОДНЫЕ',
                                selected: false,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: wrapWithModel(
                              model: _model.tabItemModel3,
                              updateCallback: () => safeSetState(() {}),
                              child: TabItemWidget(
                                label: 'ПРЕДЗАКАЗЫ',
                                selected: false,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 2.0)),
                      ),
                    ].divide(SizedBox(height: 12.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 4.0,
                                    height: 16.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                  Text(
                                    'АКТИВНЫЕ',
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          font: GoogleFonts.notoSansJp(
                                            fontWeight: FontWeight.w900,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w900,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                          lineHeight: 1.1,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                              wrapWithModel(
                                model: _model.orderItemModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: OrderItemWidget(
                                  address: 'ул. Ленина, д. 42, кв. 15',
                                  category: 'Химчистка дивана',
                                  distance: '2.4 км',
                                  price: '3 200 ₽',
                                  status: 'В ПУТИ',
                                  statusColor:
                                      FlutterFlowTheme.of(context).warning,
                                  time: 'СЕГОДНЯ, 14:30',
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 4.0,
                                    height: 16.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                  Text(
                                    'БЛИЖАЙШИЕ',
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          font: GoogleFonts.notoSansJp(
                                            fontWeight: FontWeight.w900,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w900,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                          lineHeight: 1.1,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                              wrapWithModel(
                                model: _model.orderItemModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: OrderItemWidget(
                                  address: 'Пр. Мира, д. 102, корп. 1',
                                  category: 'Генеральная уборка',
                                  distance: '5.8 км',
                                  price: '5 500 ₽',
                                  status: 'НАЗНАЧЕН',
                                  statusColor:
                                      FlutterFlowTheme.of(context).info,
                                  time: 'СЕГОДНЯ, 18:00',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.orderItemModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: OrderItemWidget(
                                  address: 'ул. Гагарина, д. 5, под. 2',
                                  category: 'Мойка окон',
                                  distance: '1.1 км',
                                  price: '2 100 ₽',
                                  status: 'В ПУТИ',
                                  statusColor:
                                      FlutterFlowTheme.of(context).warning,
                                  time: 'ЗАВТРА, 10:00',
                                ),
                              ),
                            ].divide(SizedBox(height: 12.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 80.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                child: Container(
                  child: wrapWithModel(
                    model: _model.bottomNavModel,
                    updateCallback: () => safeSetState(() {}),
                    child: BottomNavWidget(
                      child: () => BottomNavChildWidget(),
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
