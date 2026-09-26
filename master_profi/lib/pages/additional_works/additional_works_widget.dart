import '/components/added_work_row/added_work_row_widget.dart';
import '/components/button/button_widget.dart';
import '/components/service_item2/service_item2_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'additional_works_model.dart';
export 'additional_works_model.dart';

class AdditionalWorksWidget extends StatefulWidget {
  const AdditionalWorksWidget({super.key});

  static String routeName = 'AdditionalWorks';
  static String routePath = '/additionalWorks';

  @override
  State<AdditionalWorksWidget> createState() => _AdditionalWorksWidgetState();
}

class _AdditionalWorksWidgetState extends State<AdditionalWorksWidget> {
  late AdditionalWorksModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdditionalWorksModel());
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
                padding: EdgeInsets.all(16.0),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FlutterFlowIconButton(
                        borderRadius: 8.0,
                        buttonSize: 40.0,
                        fillColor: Colors.transparent,
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: FlutterFlowTheme.of(context).onPrimary,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          context.goNamed(ActiveOrderDetailWidget.routeName);
                        },
                      ),
                      Text(
                        'ДОП. РАБОТЫ',
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.notoSansJp(
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).onPrimary,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                  lineHeight: 1.2,
                                ),
                      ),
                      Container(
                        width: 24.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'ВЫБЕРИТЕ УСЛУГИ',
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        font: GoogleFonts.notoSansJp(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                        lineHeight: 1.1,
                                      ),
                                ),
                                wrapWithModel(
                                  model: _model.serviceItemModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ServiceItem2Widget(
                                    price: '350 ₽',
                                    title: 'Стул (без спинки)',
                                    isSelected: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.serviceItemModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ServiceItem2Widget(
                                    price: '500 ₽',
                                    title: 'Стул со спинкой',
                                    isSelected: true,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.serviceItemModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ServiceItem2Widget(
                                    price: '1 200 ₽',
                                    title: 'Кресло',
                                    isSelected: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.serviceItemModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ServiceItem2Widget(
                                    price: '250 ₽',
                                    title: 'Подушка декоративная',
                                    isSelected: true,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.serviceItemModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ServiceItem2Widget(
                                    price: '800 ₽',
                                    title: 'Выведение сложных пятен',
                                    isSelected: false,
                                  ),
                                ),
                              ].divide(SizedBox(height: 8.0)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondary,
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'ИТОГО К ДОБАВЛЕНИЮ',
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              font: GoogleFonts.notoSansJp(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                              lineHeight: 1.1,
                                            ),
                                      ),
                                      wrapWithModel(
                                        model: _model.addedWorkRowModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: AddedWorkRowWidget(
                                          name: 'Стул со спинкой',
                                          qty: '2',
                                          total: '1 000 ₽',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.addedWorkRowModel2,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: AddedWorkRowWidget(
                                          name: 'Подушка декоративная',
                                          qty: '2',
                                          total: '500 ₽',
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 8.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'СУММА ДОП. РАБОТ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                        lineHeight: 1.4,
                                                      ),
                                            ),
                                            Text(
                                              '1 500 ₽',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleLarge
                                                  .override(
                                                    font:
                                                        GoogleFonts.notoSansJp(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w900,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleLarge
                                                            .fontStyle,
                                                    lineHeight: 1.2,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 8.0)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFFF9C4),
                                borderRadius: BorderRadius.circular(2.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Color(0xFFFBC02D),
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.info_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 18.0,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Клиент должен подтвердить изменения в своём приложении',
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                font: GoogleFonts.notoSansJp(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                                lineHeight: 1.1,
                                              ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 4.0)),
                                  ),
                                ),
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
            SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary,
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context
                                  .goNamed(ActiveOrderDetailWidget.routeName);
                            },
                            child: wrapWithModel(
                              model: _model.buttonModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: ButtonWidget(
                                iconPresent: false,
                                iconEndPresent: false,
                                content: 'ОТМЕНИТЬ',
                                variant: 'ghost',
                                size: 'medium',
                                fullWidth: false,
                                loading: false,
                                disabled: false,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tertiary,
                              borderRadius: BorderRadius.circular(2.0),
                              shape: BoxShape.rectangle,
                            ),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context
                                    .goNamed(ActiveOrderDetailWidget.routeName);
                              },
                              child: wrapWithModel(
                                model: _model.buttonModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: ButtonWidget(
                                  iconPresent: false,
                                  iconEndPresent: false,
                                  content: 'ОТПРАВИТЬ',
                                  variant: 'primary',
                                  size: 'medium',
                                  fullWidth: true,
                                  loading: false,
                                  disabled: false,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
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
