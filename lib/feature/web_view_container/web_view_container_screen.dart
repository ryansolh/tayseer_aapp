import 'package:flutter/material.dart';
import 'package:todo_apps/cache/cache_helper.dart';
import 'package:todo_apps/core/component/my_custom_loading.dart';
import 'package:todo_apps/core/utils/app_constants/blog_app_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        body: Stack(
          children: <Widget>[
            WebView(
              userAgent: CacheHelper.getData(key: "token2"),

              initialUrl: baseUrl+'vendor/dashboard', // رابط HTTP
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
              },
              onPageStarted: (String url) {
                setState(() {
                  _isLoading = true;
                });
              },
              onPageFinished: (String url) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
            if (_isLoading)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).colorScheme.background,
                child: MyCustomLoading(),
              )
          ],
        ),
      ),
    );
  }
}