import '/backend/api_requests/api_calls.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/row_back/row_back_widget.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'show_agreement_model.dart';
export 'show_agreement_model.dart';

class ShowAgreementWidget extends StatefulWidget {
  const ShowAgreementWidget({
    Key? key,
    this.slug,
    required this.nextslug,
    required this.nextsort,
  }) : super(key: key);

  final String? slug;
  final String? nextslug;
  final int? nextsort;

  @override
  _ShowAgreementWidgetState createState() => _ShowAgreementWidgetState();
}

class _ShowAgreementWidgetState extends State<ShowAgreementWidget> {
  late ShowAgreementModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShowAgreementModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'ShowAgreement'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SHOW_AGREEMENT_ShowAgreement_ON_INIT_STA');
      logFirebaseEvent('ShowAgreement_backend_call');
      _model.apiResultProduct02 = await HappyGoAPIGroup.nextmoduleCall.call(
        token: FFAppState().Token,
        productID: FFAppState().prodslug,
        code: widget.nextslug,
        sort: widget.nextsort,
      );
      logFirebaseEvent('ShowAgreement_update_widget_state');
      _model.nextSl = HappyGoAPIGroup.nextmoduleCall
          .code(
            (_model.apiResultProduct02?.jsonBody ?? ''),
          )
          .toString();
      _model.nextSo = HappyGoAPIGroup.nextmoduleCall.sort(
        (_model.apiResultProduct02?.jsonBody ?? ''),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 400.0,
                maxHeight: 900.0,
              ),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.00, 0.00),
                    child: wrapWithModel(
                      model: _model.rowBackModel,
                      updateCallback: () => setState(() {}),
                      child: RowBackWidget(),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1.00, 0.00),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(25.0, 13.0, 0.0, 0.0),
                      child: Text(
                        'Договор',
                        style:
                            FlutterFlowTheme.of(context).displaySmall.override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(25.0, 24.0, 25.0, 20.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'SHOW_AGREEMENT_Container-title_ON_TAP');
                        logFirebaseEvent(
                            'Container-title_upload_media_to_firebase');
                        final selectedMedia =
                            await selectMediaWithSourceBottomSheet(
                          context: context,
                          allowPhoto: true,
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          setState(() => _model.isDataUploading = true);
                          var selectedUploadedFiles = <FFUploadedFile>[];

                          var downloadUrls = <String>[];
                          try {
                            showUploadMessage(
                              context,
                              'Uploading file...',
                              showLoading: true,
                            );
                            selectedUploadedFiles = selectedMedia
                                .map((m) => FFUploadedFile(
                                      name: m.storagePath.split('/').last,
                                      bytes: m.bytes,
                                      height: m.dimensions?.height,
                                      width: m.dimensions?.width,
                                      blurHash: m.blurHash,
                                    ))
                                .toList();

                            downloadUrls = (await Future.wait(
                              selectedMedia.map(
                                (m) async =>
                                    await uploadData(m.storagePath, m.bytes),
                              ),
                            ))
                                .where((u) => u != null)
                                .map((u) => u!)
                                .toList();
                          } finally {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            _model.isDataUploading = false;
                          }
                          if (selectedUploadedFiles.length ==
                                  selectedMedia.length &&
                              downloadUrls.length == selectedMedia.length) {
                            setState(() {
                              _model.uploadedLocalFile =
                                  selectedUploadedFiles.first;
                              _model.uploadedFileUrl = downloadUrls.first;
                            });
                            showUploadMessage(context, 'Success!');
                          } else {
                            setState(() {});
                            showUploadMessage(context, 'Failed to upload data');
                            return;
                          }
                        }

                        logFirebaseEvent('Container-title_wait__delay');
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F1FE),
                          borderRadius: BorderRadius.circular(11.0),
                          border: Border.all(
                            color: Color(0xFFEFEFF4),
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(-1.00, 0.05),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 13.0, 0.0, 13.0),
                            child: Text(
                              'Документ для подписания',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(28.0),
                            topRight: Radius.circular(28.0),
                          ),
                        ),
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.6,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                              topLeft: Radius.circular(28.0),
                              topRight: Radius.circular(28.0),
                            ),
                          ),
                          alignment: AlignmentDirectional(0.00, -1.00),
                          child: FlutterFlowPdfViewer(
                            assetPath: 'assets/pdfs/bs6js__.pdf',
                            horizontalScroll: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(28.0),
                        topRight: Radius.circular(28.0),
                      ),
                    ),
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.1,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(28.0),
                          topRight: Radius.circular(28.0),
                        ),
                      ),
                      alignment: AlignmentDirectional(0.00, -1.00),
                      child: Align(
                        alignment: AlignmentDirectional(0.00, 0.00),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onLongPress: () async {
                                  logFirebaseEvent(
                                      'SHOW_AGREEMENT_ДАЛЕЕ_BTN_ON_LONG_PRESS');
                                  if (widget.nextslug == 'show_agreement') {
                                    logFirebaseEvent('Button_navigate_to');

                                    context.pushNamed(
                                      'ShowAgreement',
                                      queryParameters: {
                                        'slug': serializeParam(
                                          '',
                                          ParamType.String,
                                        ),
                                        'nextslug': serializeParam(
                                          '',
                                          ParamType.String,
                                        ),
                                        'nextsort': serializeParam(
                                          0,
                                          ParamType.int,
                                        ),
                                      }.withoutNulls,
                                    );
                                  } else {
                                    if (FFAppState().nextslug == 'photos') {
                                      logFirebaseEvent('Button_navigate_to');

                                      context.pushNamed(
                                        'Photos',
                                        queryParameters: {
                                          'slug': serializeParam(
                                            widget.slug,
                                            ParamType.String,
                                          ),
                                          'nextslug': serializeParam(
                                            FFAppState().nextslug,
                                            ParamType.String,
                                          ),
                                          'nextsort': serializeParam(
                                            FFAppState().nextsort,
                                            ParamType.int,
                                          ),
                                        }.withoutNulls,
                                      );
                                    } else {
                                      if (FFAppState().nextslug ==
                                          'wire_card') {
                                        logFirebaseEvent('Button_navigate_to');

                                        context.pushNamed('Binding');
                                      } else {
                                        if (FFAppState().nextslug ==
                                            'wire_card') {
                                          logFirebaseEvent(
                                              'Button_navigate_to');

                                          context.pushNamed('Binding');
                                        } else {
                                          if (FFAppState().nextslug ==
                                              'send_sms') {
                                            logFirebaseEvent(
                                                'Button_navigate_to');

                                            context.pushNamed('SigningSms');
                                          } else {
                                            if (FFAppState().nextslug ==
                                                'check_report') {
                                              logFirebaseEvent(
                                                  'Button_navigate_to');

                                              context
                                                  .pushNamed('proverka-ankety');
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                },
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'SHOW_AGREEMENT_PAGE_ДАЛЕЕ_BTN_ON_TAP');
                                    logFirebaseEvent('Button_backend_call');
                                    _model.apiResultProduct2 =
                                        await HappyGoAPIGroup.nextmoduleCall
                                            .call(
                                      token: FFAppState().Token,
                                      productID: FFAppState().prodslug,
                                      code: widget.nextslug,
                                      sort: widget.nextsort,
                                    );
                                    logFirebaseEvent(
                                        'Button_update_widget_state');
                                    _model.nextSl = HappyGoAPIGroup
                                        .nextmoduleCall
                                        .code(
                                          (_model.apiResultProduct2?.jsonBody ??
                                              ''),
                                        )
                                        .toString();
                                    _model.nextSo =
                                        HappyGoAPIGroup.nextmoduleCall.sort(
                                      (_model.apiResultProduct2?.jsonBody ??
                                          ''),
                                    );
                                    if ((_model.apiResultProduct2?.succeeded ??
                                        true)) {
                                      if (_model.nextSl == 'show_agreement') {
                                        logFirebaseEvent('Button_navigate_to');

                                        context.pushNamed(
                                          'ShowAgreement',
                                          queryParameters: {
                                            'slug': serializeParam(
                                              FFAppState().slug,
                                              ParamType.String,
                                            ),
                                            'nextslug': serializeParam(
                                              _model.nextSl,
                                              ParamType.String,
                                            ),
                                            'nextsort': serializeParam(
                                              _model.nextSo,
                                              ParamType.int,
                                            ),
                                          }.withoutNulls,
                                        );
                                      } else {
                                        if (_model.nextSl == 'photos') {
                                          logFirebaseEvent(
                                              'Button_navigate_to');

                                          context.pushNamed(
                                            'Photos',
                                            queryParameters: {
                                              'slug': serializeParam(
                                                FFAppState().slug,
                                                ParamType.String,
                                              ),
                                              'nextslug': serializeParam(
                                                _model.nextSl,
                                                ParamType.String,
                                              ),
                                              'nextsort': serializeParam(
                                                _model.nextSo,
                                                ParamType.int,
                                              ),
                                            }.withoutNulls,
                                          );
                                        } else {
                                          if (_model.nextSl == 'wire_card') {
                                            logFirebaseEvent(
                                                'Button_navigate_to');

                                            context.pushNamed(
                                              'Binding',
                                              queryParameters: {
                                                'nextslug': serializeParam(
                                                  _model.nextSl,
                                                  ParamType.String,
                                                ),
                                                'nextsort': serializeParam(
                                                  _model.nextSo,
                                                  ParamType.int,
                                                ),
                                                'slug': serializeParam(
                                                  FFAppState().slug,
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                            );
                                          } else {
                                            if (FFAppState().nextslug ==
                                                'verification') {
                                              logFirebaseEvent(
                                                  'Button_navigate_to');

                                              context.pushNamed(
                                                'proverka-ankety',
                                                queryParameters: {
                                                  'slug': serializeParam(
                                                    FFAppState().slug,
                                                    ParamType.String,
                                                  ),
                                                  'nextslug': serializeParam(
                                                    _model.nextSl,
                                                    ParamType.String,
                                                  ),
                                                  'nextsort': serializeParam(
                                                    _model.nextSo,
                                                    ParamType.int,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            } else {
                                              if (_model.nextSl == 'send_sms') {
                                                logFirebaseEvent(
                                                    'Button_navigate_to');

                                                context.pushNamed(
                                                  'SigningSms',
                                                  queryParameters: {
                                                    'slug': serializeParam(
                                                      FFAppState().slug,
                                                      ParamType.String,
                                                    ),
                                                    'nextslug': serializeParam(
                                                      _model.nextSl,
                                                      ParamType.String,
                                                    ),
                                                    'nextsort': serializeParam(
                                                      _model.nextSo,
                                                      ParamType.int,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              } else {
                                                if (_model.nextSl ==
                                                    'check_report') {
                                                  logFirebaseEvent(
                                                      'Button_navigate_to');

                                                  context.pushNamed(
                                                    'proverka-ankety',
                                                    queryParameters: {
                                                      'slug': serializeParam(
                                                        FFAppState().slug,
                                                        ParamType.String,
                                                      ),
                                                      'nextslug':
                                                          serializeParam(
                                                        _model.nextSl,
                                                        ParamType.String,
                                                      ),
                                                      'nextsort':
                                                          serializeParam(
                                                        _model.nextSo,
                                                        ParamType.int,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                } else {
                                                  if (_model.nextSl ==
                                                      'cross_product') {
                                                    logFirebaseEvent(
                                                        'Button_navigate_to');

                                                    context.pushNamed(
                                                      'DopMain',
                                                      queryParameters: {
                                                        'slug': serializeParam(
                                                          FFAppState().slug,
                                                          ParamType.String,
                                                        ),
                                                        'nextslug':
                                                            serializeParam(
                                                          _model.nextSl,
                                                          ParamType.String,
                                                        ),
                                                        'nextsort':
                                                            serializeParam(
                                                          _model.nextSo,
                                                          ParamType.int,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    } else {
                                      logFirebaseEvent('Button_show_snack_bar');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Модули в сценарии закончились',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 2000),
                                          backgroundColor: Color(0xFFB8CFF5),
                                        ),
                                      );
                                      logFirebaseEvent('Button_wait__delay');
                                      await Future.delayed(
                                          const Duration(milliseconds: 2000));
                                      logFirebaseEvent('Button_navigate_to');

                                      context.pushNamed(
                                        'DopMain',
                                        queryParameters: {
                                          'slug': serializeParam(
                                            FFAppState().slug,
                                            ParamType.String,
                                          ),
                                          'nextslug': serializeParam(
                                            _model.nextSl,
                                            ParamType.String,
                                          ),
                                          'nextsort': serializeParam(
                                            _model.nextSo,
                                            ParamType.int,
                                          ),
                                        }.withoutNulls,
                                      );
                                    }

                                    setState(() {});
                                  },
                                  text: 'ДАЛЕЕ',
                                  options: FFButtonOptions(
                                    width: 327.0,
                                    height: 38.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Color(0xFF4460F0),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          letterSpacing: 0.6,
                                          fontWeight: FontWeight.bold,
                                          lineHeight: 1.5,
                                        ),
                                    elevation: 2.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  showLoadingIndicator: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
