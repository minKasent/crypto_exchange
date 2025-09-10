import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingChartScreen extends StatefulWidget {
  const TradingChartScreen({super.key});

  @override
  State<TradingChartScreen> createState() => _TradingChartScreenState();
}

class _TradingChartScreenState extends State<TradingChartScreen> {
  late WebViewController webViewController;
  String symbol = 'BTCUSDT';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      symbol = ModalRoute.of(context)!.settings.arguments as String;
      webViewController =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(Colors.black)
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  // Update loading bar.
                },
                onPageStarted: (String url) {},
                onPageFinished: (String url) {
                  setState(() {
                    isLoading = false;
                  });
                },
                onHttpError: (HttpResponseError error) {},
                onWebResourceError: (WebResourceError error) {},
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(
              Uri.parse(
                'https://www.tradingview.com/chart/?symbol=BINANCE%3A$symbol',
              ),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: Container(
        height: 400,
        color: Colors.amber,
        child:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : WebViewWidget(controller: webViewController),
      ),
    );
  }
}
