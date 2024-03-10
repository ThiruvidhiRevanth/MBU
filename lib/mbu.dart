import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// ignore: unused_import
import 'dart:async';

void main() {
  runApp( cMyApp());
}



class cMyApp extends StatefulWidget {
  cMyApp ({Key? key}) : super(key: key);

  @override
  State<cMyApp> createState() => _cMyAppState();
}

class _cMyAppState extends State<cMyApp> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("Loading: $progress%");
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
          
            _controller.runJavaScriptReturningResult('''
              var header = document.querySelector('#mm-0 > div > footer > div.kingster-copyright-wrapper > div'); 
              var header1 = document.querySelector('#gdlr-core-custom-menu-widget-4'); 


              if (header ) {
                header.style.display = 'none';
              }
              if(header1){
                header1.style.display = 'none';
              }
              
            ''');
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://www.mbu.asia/"));

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor:Color(0xFFfecc14),
         toolbarHeight: 3,
         
      ),
      
      body: SizedBox(
        width: double.infinity,
        
        child: WebViewWidget(
          controller: _controller,
        ),
      
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await _controller.canGoBack()) {
            _controller.goBack();
          }
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.amberAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
    
  }
}