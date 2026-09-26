import '/components/button/button_widget.dart';
import '/components/saved_address_item/saved_address_item_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'searching_for_address_model.dart';
export 'searching_for_address_model.dart';

class SearchingForAddressWidget extends StatefulWidget {
  const SearchingForAddressWidget({super.key});

  static String routeName = 'SearchingForAddress';
  static String routePath = '/searchingForAddress';

  @override
  State<SearchingForAddressWidget> createState() =>
      _SearchingForAddressWidgetState();
}

class _SearchingForAddressWidgetState extends State<SearchingForAddressWidget> {
  late SearchingForAddressModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchingForAddressModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.myLocation = await actions.getMyLocation();
      if (_model.myLocation != null && (_model.myLocation)!.isNotEmpty) {
        FFAppState().myLat = (_model.myLocation!.elementAtOrNull(0))!;
        FFAppState().myLng = (_model.myLocation!.elementAtOrNull(1))!;
        safeSetState(() {});
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor: Colors.transparent,
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () async {},
                              ),
                              Expanded(
                                flex: 1,
                                child: wrapWithModel(
                                  model: _model.textFieldModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TextFieldWidget(
                                    label: '',
                                    labelPresent: false,
                                    helper: '',
                                    helperPresent: false,
                                    leadingIcon: Icon(
                                      Icons.search_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                    leadingIconPresent: true,
                                    trailingIconPresent: false,
                                    hint: 'Поиск адреса в Яндексе',
                                    value: '',
                                    onChange: '',
                                    onSubmit: '',
                                    variant: 'filled',
                                    error: false,
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ].divide(SizedBox(height: 16.0)),
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
            ),
            Expanded(
              flex: 1,
              child: Stack(
                alignment: AlignmentDirectional(-1.0, -1.0),
                children: [
                  Container(
                    child: Container(
                      width: double.infinity,
                      height: 400.0,
                      child: custom_widgets.OsmMapWidget(
                        width: double.infinity,
                        height: 400.0,
                        centerLat: FFAppState().myLat,
                        centerLng: FFAppState().myLng,
                        initialZoom: 16.0,
                        autoLoadMasters: false,
                        showRoute: false,
                        pickLocation: true,
                        onMasterTap: (masterId) async {},
                        onRouteInfo: (route) async {},
                        onCenterChanged: (point) async {
                          FFAppState().orderLat = point.elementAtOrNull(0)!;
                          FFAppState().orderLng = point.elementAtOrNull(1)!;
                          safeSetState(() {});
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(40.0, 0.0, 40.0, 0.0),
                      child: Container(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  borderRadius: BorderRadius.circular(12.0),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 8.0, 16.0, 8.0),
                                  child: Container(
                                    child: Text(
                                      'Укажите место на карте',
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .onPrimary,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                            lineHeight: 1.2,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.location_on_rounded,
                                color: FlutterFlowTheme.of(context).error,
                                size: 40.0,
                              ),
                            ].divide(SizedBox(height: 0.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(1.0, 1.0),
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Container(
                        alignment: AlignmentDirectional(1.0, 1.0),
                        child: FlutterFlowIconButton(
                          borderRadius: 9999.0,
                          buttonSize: 40.0,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          icon: Icon(
                            Icons.my_location_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24.0),
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
                              Icon(
                                Icons.location_on_rounded,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 24.0,
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ул. Ленина, 15',
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            font: GoogleFonts.manrope(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                            lineHeight: 1.4,
                                          ),
                                    ),
                                    Text(
                                      'Краснознаменск, Московская обл.',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                            lineHeight: 1.4,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 4.0)),
                                ),
                              ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: wrapWithModel(
                                  model: _model.textFieldModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TextFieldWidget(
                                    label: 'Подъезд',
                                    labelPresent: true,
                                    helper: '',
                                    helperPresent: false,
                                    leadingIconPresent: false,
                                    trailingIconPresent: false,
                                    hint: '1',
                                    value: '',
                                    onChange: '',
                                    onSubmit: '',
                                    variant: 'outlined',
                                    error: false,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: wrapWithModel(
                                  model: _model.textFieldModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TextFieldWidget(
                                    label: 'Квартира',
                                    labelPresent: true,
                                    helper: '',
                                    helperPresent: false,
                                    leadingIconPresent: false,
                                    trailingIconPresent: false,
                                    hint: '42',
                                    value: '',
                                    onChange: '',
                                    onSubmit: '',
                                    variant: 'outlined',
                                    error: false,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: wrapWithModel(
                                  model: _model.textFieldModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TextFieldWidget(
                                    label: 'Этаж',
                                    labelPresent: true,
                                    helper: '',
                                    helperPresent: false,
                                    leadingIconPresent: false,
                                    trailingIconPresent: false,
                                    hint: '5',
                                    value: '',
                                    onChange: '',
                                    onSubmit: '',
                                    variant: 'outlined',
                                    error: false,
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                          wrapWithModel(
                            model: _model.textFieldModel5,
                            updateCallback: () => safeSetState(() {}),
                            child: TextFieldWidget(
                              label: 'Домофон / Комментарий',
                              labelPresent: true,
                              helper: '',
                              helperPresent: false,
                              leadingIconPresent: false,
                              trailingIconPresent: false,
                              hint: 'Код 123, лифт справа',
                              value: '',
                              onChange: '',
                              onSubmit: '',
                              variant: 'outlined',
                              error: false,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Мои адреса',
                                style: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      font: GoogleFonts.openSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontStyle,
                                      lineHeight: 1.3,
                                    ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    wrapWithModel(
                                      model: _model.savedAddressItemModel1,
                                      updateCallback: () => safeSetState(() {}),
                                      child: SavedAddressItemWidget(
                                        address: 'ул. Ленина, 15',
                                        icon: Icon(
                                          Icons.home_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 20.0,
                                        ),
                                        title: 'Дом',
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.savedAddressItemModel2,
                                      updateCallback: () => safeSetState(() {}),
                                      child: SavedAddressItemWidget(
                                        address: 'пр-т Мира, 17',
                                        icon: Icon(
                                          Icons.work_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 20.0,
                                        ),
                                        title: 'Работа',
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 16.0)),
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              FFAppState().orderAddress = '';
                              safeSetState(() {});
                              context.safePop();
                            },
                            child: wrapWithModel(
                              model: _model.buttonModel,
                              updateCallback: () => safeSetState(() {}),
                              child: ButtonWidget(
                                iconPresent: false,
                                iconEndPresent: false,
                                content: 'Подтвердить адрес',
                                variant: 'primary',
                                size: 'large',
                                fullWidth: true,
                                loading: false,
                                disabled: false,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(height: 24.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
