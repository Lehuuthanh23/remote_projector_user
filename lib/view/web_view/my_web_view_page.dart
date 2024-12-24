import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/app_color.dart';
import '../../widget/base_page.dart';

class MyWebViewPage extends StatefulWidget {
  final String url;

  const MyWebViewPage({super.key, required this.url});

  @override
  State<MyWebViewPage> createState() => _MyWebViewPageState();
}

class _MyWebViewPageState extends State<MyWebViewPage> {
  late WebViewController _controller;
  Widget? _title;
  double _progress = 0;

  @override
  void initState() {
    super.initState();

    try {
      _controller = WebViewController();
      _controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..enableZoom(true)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (p) {
              if (mounted) {
                setState(() {
                  _progress = p / 100;
                });
              }
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) async {
              String? titleString = await _controller.getTitle();
              if (mounted) {
                if (titleString.isEmptyOrNull) {
                  loadUrl();
                } else {
                  setState(() {
                  _title = Text(
                    titleString!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  );
                });
                }
              }
            },
            onHttpError: (HttpResponseError error) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
          ),
        );
      loadUrl();
    } catch(e) {
      loadUrl();
    }
  }

  void loadUrl() {
    _progress = 0;
    _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    _controller.clearCache();
    _controller.clearLocalStorage();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasePage(
        showAppBar: true,
        showLeadingAction: true,
        title: _title ?? 'Đang tải...',
        body: Column(
          children: [
            if (_progress > 0 && _progress < 1)
              LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.white,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColor.unSelectedLabel2),
              ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: WebViewWidget(controller: _controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
