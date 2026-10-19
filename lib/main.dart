import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

const String sigaLoginUrl = 'https://siga.cps.sp.gov.br/sigaaluno/applogin.aspx';
const String sigaUserAgent =
    'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SigaApp());
}

class SigaApp extends StatelessWidget {
  const SigaApp({super.key, this.home = const SigaWebView()});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIGA Alunos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: home,
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
  final ValueNotifier<double> progress = ValueNotifier(0);
  final ValueNotifier<bool> hasError = ValueNotifier(false);

  @override
  void dispose() {
    progress.dispose();
    hasError.dispose();
    super.dispose();
  }

  Future<void> _retry() async {
    hasError.value = false;
    await webViewController?.reload();
  }

  Future<void> _onBack() async {
    final controller = webViewController;
    if (controller != null && await controller.canGoBack()) {
      await controller.goBack();
    } else {
      await SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _onBack();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SIGA Alunos'),
          actions: [
            IconButton(
              tooltip: 'Recarregar',
              icon: const Icon(Icons.refresh),
              onPressed: _retry,
            ),
          ],
        ),
        body: Column(
          children: [
            ValueListenableBuilder<double>(
              valueListenable: progress,
              builder: (context, value, _) =>
                  value < 1.0 ? LinearProgressIndicator(value: value) : const SizedBox.shrink(),
            ),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: WebUri(sigaLoginUrl)),
                    initialSettings: InAppWebViewSettings(
                      javaScriptEnabled: true,
                      domStorageEnabled: true,
                      thirdPartyCookiesEnabled: true,
                      cacheEnabled: true,
                      userAgent: sigaUserAgent,
                    ),
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    onProgressChanged: (controller, value) {
                      progress.value = value / 100;
                    },
                    onLoadStart: (controller, url) {
                      hasError.value = false;
                    },
                    onReceivedError: (controller, request, error) {
                      if (request.isForMainFrame ?? false) {
                        hasError.value = true;
                      }
                    },
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: hasError,
                    builder: (context, failed, _) {
                      if (!failed) return const SizedBox.shrink();
                      return ColoredBox(
                        color: Theme.of(context).colorScheme.surface,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.wifi_off, size: 48),
                              const SizedBox(height: 12),
                              const Text('Não foi possível carregar o SIGA.'),
                              const SizedBox(height: 12),
                              FilledButton(
                                onPressed: _retry,
                                child: const Text('Tentar novamente'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
