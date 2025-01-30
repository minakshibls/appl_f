import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../utils/colors.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String heading;

  const WebViewScreen({super.key, required this.url, required this.heading});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();

    // Set the platform for Android
    WebViewPlatform.instance ??= AndroidWebViewPlatform();

    // If targeting iOS, set the platform for iOS
    // if (WebViewPlatform.instance == null) {
    //   WebViewPlatform.instance = WebKitWebView();
    // }
  }

  @override
  Widget build(BuildContext context) {
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onHttpAuthRequest: (request) {

            print("request");
            print(request);
          },
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {
          },
          onWebResourceError: (WebResourceError error) {
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        )
      )
      ..loadRequest(Uri.parse(widget.url));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.heading,
          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
