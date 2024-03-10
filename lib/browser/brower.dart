import 'package:flutter/material.dart';
import 'package:mbu/browser/browerapi.dart';
import 'package:mbu/browser/browerclass.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const Browser());
}

class Browser extends StatefulWidget {
  const Browser({super.key});

  @override
  State<Browser> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  void initState() {
    super.initState();
    _createBannerAd();
    fetechuser();
  }

  BannerAdListener bannerAdListener = BannerAdListener(
    onAdWillDismissScreen: (ad) {
      ad.dispose();
    },
    onAdClosed: (ad) {
      debugPrint("Ad Got Closed");
    },
  );

  void _createBannerAd() {
    _banner = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-8722757288729729/6676686387',
      listener: bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  BannerAd? _banner;
  List<Useres> users = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 3,
        backgroundColor: Colors.amber[300],
      ),
      body: ListView.builder(
        itemCount: users.length + (users.length ~/ 2), // Adjusting for banners
        itemBuilder: (context, index) {
          if (index != 0 && index % 2 == 0) {
            // Show banner after every three items
            return Column(
              children: [
                _getListItemTile(context, index - (index ~/ 2) - 1),
                if (_banner != null)
                  Container(
                    height: _banner!.size.height.toDouble(),
                    child: AdWidget(ad: _banner!),
                  ),
              ],
            );
          } else {
            return _getListItemTile(context, index - (index ~/ 2));
          }
        },
      ),
    );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    final user = users[index];

    return GestureDetector(
      onDoubleTap: () async {
        var url = Uri.parse(user.browserurl);

        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.inAppWebView);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Container(
        margin: const EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 10.0,
              offset: Offset(9.0, 8.0),
            )
          ],
        ),
        padding: const EdgeInsets.fromLTRB(3, 5, 3, 5),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(user.browserpic),
          ),
          title: Text(
            user.browsertitle,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(user.browsertext),
        ),
      ),
    );
  }

  Future<void> fetechuser() async {
    final response = await browserapi.fetechuser();
    try {
      setState(() {
        users = response;
      });
    } catch (e) {}
  }
}
