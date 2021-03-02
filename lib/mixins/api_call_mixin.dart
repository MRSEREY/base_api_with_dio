import 'package:base_api_with_dio/exceptions/network_exception.dart';
import 'package:base_api_with_dio/models/network_error_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin ApiCallMixin<T extends StatefulWidget> on State<T> {
  bool showError = false;
  bool showLoading = false;
  NetWorkErrorModel errorNetwork;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          builder(context),
          loading(context),
          dialog(context),
        ],
      ),
    );
  }

  apiCall(Function func) async {
    setState(() {
      showLoading = true;
    });
    try {
      var response = await func();
      setState(() {
        showLoading = false;
      });
      return response;
    } on DioError catch (e) {
      print(e.response);
      NetWorkException netWorkException = NetWorkException(e);
      NetWorkErrorModel error = netWorkException.translateException();
      setState(() {
        showError = true;
        showLoading = false;
        errorNetwork = error;
      });
    }
  }

  builder(BuildContext context);

  loading(BuildContext context) {
    return Visibility(
      visible: !showError && showLoading,
      child: Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black12,
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              child: SizedBox(
                child: CupertinoActivityIndicator(),
                height: 80.0,
                width: 80.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  dialog(BuildContext context) {
    return Visibility(
      visible: showError,
      child: Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black12,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5),
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.error, color: Colors.red),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _errorTitle(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              errorNetwork?.description ?? '',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () async {
                        setState(() {
                          showError = false;
                        });
                      },
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.red),
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

  _errorTitle() {
    if (errorNetwork?.title == 'unexpectedError') {
      return '${errorNetwork?.title} ${errorNetwork?.statusCode ?? ''}';
    }
    return errorNetwork?.title ?? '';
  }
}
