import '/auth/firebase_auth/auth_util.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/row_back/row_back_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'signing_client_model.dart';
export 'signing_client_model.dart';

class SigningClientWidget extends StatefulWidget {
  const SigningClientWidget({
    Key? key,
    this.slug,
  }) : super(key: key);

  final String? slug;

  @override
  _SigningClientWidgetState createState() => _SigningClientWidgetState();
}

class _SigningClientWidgetState extends State<SigningClientWidget> {
  late SigningClientModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SigningClientModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'SigningClient'});
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
              child: Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    wrapWithModel(
                      model: _model.rowBackModel,
                      updateCallback: () => setState(() {}),
                      child: RowBackWidget(),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.00, 0.00),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  25.0, 13.0, 0.0, 0.0),
                              child: Text(
                                'Подписание клиент',
                                style: FlutterFlowTheme.of(context)
                                    .displaySmall
                                    .override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 24.0, 25.0, 20.0),
                            child: Container(
                              height: 70.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F1FE),
                                borderRadius: BorderRadius.circular(11.0),
                                border: Border.all(
                                  color: Color(0xFFEFEFF4),
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.00, 0.05),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 10.0),
                                  child: Text(
                                    'Используйте блок для подписи ниже, чтобы нарисовать свою подпись:',
                                    textAlign: TextAlign.center,
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 0.0, 25.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(11.0),
                              ),
                              child: ClipRect(
                                child: Signature(
                                  controller: _model.signatureController ??=
                                      SignatureController(
                                    penStrokeWidth: 2.0,
                                    penColor: Colors.black,
                                    exportBackgroundColor: Colors.white,
                                  ),
                                  backgroundColor: Colors.white,
                                  height: 280.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 15.0, 25.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'SIGNING_CLIENT_PAGE_Button-again_ON_TAP');
                                logFirebaseEvent(
                                    'Button-again_clear_signatures');
                                setState(() {
                                  _model.signatureController?.clear();
                                });
                              },
                              text: 'ОЧИСТИТЬ',
                              options: FFButtonOptions(
                                width: 327.0,
                                height: 48.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFFEAEAEA),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF5F5F5F),
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
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              25.0, 10.0, 25.0, 16.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              logFirebaseEvent(
                                  'SIGNING_CLIENT_PAGE_Button-more_ON_TAP');
                              logFirebaseEvent('Button-more_upload_signature');
                              final signatureImage = await _model
                                  .signatureController!
                                  .toPngBytes();
                              if (signatureImage == null) {
                                showUploadMessage(
                                  context,
                                  'Signature is empty.',
                                );
                                return;
                              }
                              showUploadMessage(
                                context,
                                'Uploading signature...',
                                showLoading: true,
                              );
                              final downloadUrl = (await uploadData(
                                  getSignatureStoragePath(), signatureImage));

                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              if (downloadUrl != null) {
                                setState(() =>
                                    _model.uploadedSignatureUrl = downloadUrl);
                                showUploadMessage(
                                  context,
                                  'Success!',
                                );
                              } else {
                                showUploadMessage(
                                  context,
                                  'Failed to upload signature.',
                                );
                                return;
                              }

                              logFirebaseEvent('Button-more_navigate_to');

                              context.pushNamed('SigningAgent');
                            },
                            text: 'ПОДПИСАТЬ',
                            options: FFButtonOptions(
                              width: 327.0,
                              height: 48.0,
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
