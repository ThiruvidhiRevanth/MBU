import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mbu/browser/mbusclass.dart';
import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp( const mbus());
}

class mbus extends StatelessWidget {
  const mbus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MBU',
      theme: ThemeData(
       
      ),
      home: mbu(),
    );
  }
}


class mbu extends StatefulWidget {
  const mbu({Key? key}) : super(key: key);

  @override
  State<mbu> createState() => _mbuState();
}

class _mbuState extends State<mbu> {
 @override
  void initState() { 
    super.initState();
    _createBannerAd();

  }
   BannerAdListener bannerAdListener =
        BannerAdListener(onAdWillDismissScreen: (ad) {
      ad.dispose();
    }, onAdClosed: (ad) {
      debugPrint("Ad Got Closed");
    });
  void _createBannerAd(){
    _banner=BannerAd(size: AdSize.banner, 
    adUnitId: 'ca-app-pub-8722757288729729/6676686387', 
    listener: bannerAdListener,
     request: const AdRequest())..load();

  }
  
  BannerAd?_banner;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 50,
          
           
        title: const Text("Navigation",style: TextStyle(fontWeight: FontWeight.w400),),
        backgroundColor: Color.alphaBlend(Colors.amberAccent, Colors.red),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text("M Block-backside(101-400)"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
            ),
            TextButton(
              child: Text("MNS Block(401-900)"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdRoute()),
                );
              },
            ),
            TextButton(
              child: Text("Diploma Block(1701-2060)"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FourRoute()),
                );
              },
            ),
            TextButton(
              child: Text("Civil Block(2101-2500)"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FiveRoute()),
                );
              },
            ),
            TextButton(
              child: Text("Mechanical Block(2501-2900)"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SixRoute()),
                );
              },
            ),
            TextButton(
              child: Text("G Block(4101-4400)"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SevenRoute()),
                );
              },
            ),
       const  SizedBox(
        height: 80,
       ),
          SizedBox(
            height: 50,
     
      child:AdWidget(ad:_banner!)),
           
            
        
          ],
        ),
      ),
    );
  }
}


class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: fetchSearchItems(query),
      builder: (context, AsyncSnapshot<List<Useres>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Useres>? matchQuery = snapshot.data;
          if (matchQuery?.isEmpty ?? true) {
          return const  Center(
            child: Text('No matching Room Number found'),
          );
        }
          return ListView.builder(
            itemCount: matchQuery?.length,
            itemBuilder: (context, index) {
              var result = matchQuery?[index];
              return ListTile(
                title: Text(result?.roomNumber ?? ''),
                subtitle: Text(result?.purpose ?? '',style:const  TextStyle(fontWeight:FontWeight.w300,fontSize: 12)),
                trailing: Text(result?.location ?? ''),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: fetchSearchItems(query),
      builder: (context, AsyncSnapshot<List<Useres>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Useres>? matchQuery = snapshot.data;
      
        if (matchQuery?.isEmpty ?? true) {
          return Center(
            child: Text('No matching Room Number found'),
          );
        }
          return ListView.builder(
            itemCount: matchQuery?.length,
            itemBuilder: (context, index) {
              var result = matchQuery?[index];
              return ListTile(
                title: Text(result?.roomNumber ?? ''),
                subtitle: Text(result?.purpose ?? '',style:const  TextStyle(fontWeight:FontWeight.w400,fontSize: 16)),
                trailing: Text(result?.location ?? ''),
              );
            },
          );
        }
      },
    );
  }

 Future<List<Useres>> fetchSearchItems(String query) async {
  final response = await http.get(Uri.parse('https://thiruvidhirevanth.github.io/mbujson/navigation.json'));

  final body = response.body;
  final json = jsonDecode(body);
  final result = json['rooms'] as List<dynamic>;

  List<Useres> userList = result
      .map((e) => Useres(
            roomNumber: e['roomNumber'],
            purpose: e['purpose'],
            location: e['location'],
          ))
      .where((useres) =>
          useres.roomNumber.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return userList;
}
}


 





class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.photo)),
                Tab(icon: Icon(Icons.route)),
              ],
            ),
            title: const Text('M Block-backside(101-400)'),
          ),
          body: TabBarView(
            children: <Widget>[
              Second1(),
              Second2(),
            ],
          ),
        ),
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.photo)),
                Tab(icon: Icon(Icons.route)),
              ],
            ),
            title: const Text('MNS Block(401-900)'),
          ),
          body: TabBarView(
            children: <Widget>[
              Three1(),
              Three2(),
            ],
          ),
        ),
      ),
    );
  }
}

class FourRoute extends StatelessWidget {
  const FourRoute({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.photo)),
                Tab(icon: Icon(Icons.route)),
              ],
            ),
            title: const Text('Diploma Block(1701-2060)'),
          ),
          body: TabBarView(
            children: <Widget>[
              four1(),
              four2(),
            ],
          ),
        ),
      ),
    );
  }
}

class FiveRoute extends StatelessWidget {
  const FiveRoute({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.photo)),
                Tab(icon: Icon(Icons.route)),
              ],
            ),
            title: const Text('Civil Block(2101-2500)'),
          ),
          body: TabBarView(
            children: <Widget>[
              five1(),
              five2(),
            ],
          ),
        ),
      ),
    );
  }
}

class SixRoute extends StatelessWidget {
  const SixRoute({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.photo)),
                Tab(icon: Icon(Icons.route)),
              ],
            ),
            title: const Text('Mechanical Block(2501-2900)'),
          ),
          body: TabBarView(
            children: <Widget>[
              Six1(),
              Six2(),
            ],
          ),
        ),
      ),
    );
  }
}

class SevenRoute extends StatelessWidget {
  const SevenRoute({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.photo)),
                Tab(icon: Icon(Icons.route)),
              ],
            ),
            title: const Text('GBlock(4101-4400)'),
          ),
          body: TabBarView(
            children: <Widget>[
              Seven1(),
              Seven2(),
            ],
          ),
        ),
      ),
    );
  }
}

class Seven1 extends StatelessWidget {
  const Seven1({super.key});

@override
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: PhotoView(
          imageProvider:NetworkImage("https://thiruvidhirevanth.github.io/mbujson/mba.jpg"),
        ),
      ),
    );
  }
}

class Seven2 extends StatelessWidget {
  const Seven2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: PhotoView(
          imageProvider: NetworkImage("https://thiruvidhirevanth.github.io/mbujson/mbar.jpg"),
        ),
      ),
    );
  }
}

class Six1 extends StatelessWidget {
  const Six1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: PhotoView(
          imageProvider: NetworkImage("https://thiruvidhirevanth.github.io/mbujson/mechanical.jpg"),
        ),
      ),
    );
  }
}

class Six2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: PhotoView(
          imageProvider: NetworkImage("https://thiruvidhirevanth.github.io/mbujson/MECHr.jpg"),
        ),
      ),
    );
  }
}

class five1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: PhotoView(
          imageProvider: NetworkImage("https://thiruvidhirevanth.github.io/mbujson/civilblock.jpg"),
        ),
      ),
    );
  }
}

class five2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: PhotoView(
          imageProvider: NetworkImage("https://thiruvidhirevanth.github.io/mbujson/civilr.jpg"),
        ),
      ),
    );
  }
}

class four1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: PhotoView(
          imageProvider: NetworkImage("https://thiruvidhirevanth.github.io/mbujson/diploma.jpg"),
        ),
      ),
    );
  }
}

class four2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: PhotoView(
          imageProvider: NetworkImage("https://thiruvidhirevanth.github.io/mbujson/Diplomar.jpg"),
        ),
      ),
    );
  }
}

class Three1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: PhotoView(
          imageProvider: NetworkImage("https://thiruvidhirevanth.github.io/mbujson/mns.jpg"),
        ),
      ),
    );
  }
}

class Three2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: PhotoView(
          imageProvider: NetworkImage("https://thiruvidhirevanth.github.io/mbujson/mnsr.jpg"),
        ),
      ),
    );
  }
}

class Second1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: PhotoView(
          imageProvider: NetworkImage("https://thiruvidhirevanth.github.io/mbujson/m.jpg"),
        ),
      ),
    );
  }
}

class Second2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: PhotoView(
          imageProvider: NetworkImage("https://thiruvidhirevanth.github.io/mbujson/Mr.jpg"),
        ),
      ),
    );
  }
}
