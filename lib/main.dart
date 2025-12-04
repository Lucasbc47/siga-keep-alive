import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SigaApp());
}

class SigaApp extends StatelessWidget {
  const SigaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIGA Keep Alive',
      theme: ThemeData(primarySwatch: Colors.red, useMaterial3: true),
      home: const SigaWebView(),
    );
  }
}

class SigaWebView extends StatefulWidget {
  const SigaWebView({super.key});

  @override
  State<SigaWebView> createState() => _SigaWebViewState();
}

class _SigaWebViewState extends State<SigaWebView> {
  InAppWebViewController? webViewController;
  double progress = 0;
  bool isMinimized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIGA Keep Alive'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => webViewController?.reload(),
          ),
          IconButton(
            icon: Icon(isMinimized ? Icons.visibility : Icons.visibility_off),
            tooltip: isMinimized ? 'Mostrar navegador' : 'Minimizar navegador',
            onPressed: () {
              setState(() {
                isMinimized = !isMinimized;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (progress < 1.0) LinearProgressIndicator(value: progress),
          if (isMinimized)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 64,
                      color: Colors.green[700],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Navegador rodando em background',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sua sessão no SIGA está sendo mantida ativa',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri('https://siga.cps.sp.gov.br'),
                ),
                initialSettings: InAppWebViewSettings(
                  javaScriptEnabled: true,
                  domStorageEnabled: true,
                  thirdPartyCookiesEnabled: true,
                  cacheEnabled: true,
                  userAgent:
                      'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
                ),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onProgressChanged: (controller, progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
