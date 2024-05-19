import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Lexic lexic = Lexic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Make fire but be cautious not to hurt yourself'),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height,
        child: Drawer(
          child: ListView(
            children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,

                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.deepOrange
                    ),
                    child: Center(
                      child: Text('Menu', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ListTile(
                title: Text('Advancement'),
              ),
              ListTile(
                title: Text('Settings'),
              ),
              ListTile(
                title: Text('Help'),
              ),
              ListTile(
                title: Text('Credits'),
              ),
            ],
          ),
        ),
      ),
      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height,
        child: Drawer(
          child: ListView.builder(
            itemCount: lexic.lexicitems.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Image(image: lexic.lexicitems[index].imageprovider),
                  Text(lexic.lexicitems[index].name),
                  ListView.builder(
                    itemCount: lexic.lexicitems[index].icons.length,
                    itemBuilder: (BuildContext context, int ind_2) {
                      return Icon(lexic.lexicitems[index].icons[ind_2]);
                    }
                  ),
                ],
              );
            }
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.10,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
          ],
        ),
      ),
    );
  }
}

class Lexic {
  var lexicitems = <Item>[];

  Lexic();

  void newlexicitem(Item newitem) {
    if (!lexicitems.contains(newitem)) {
      lexicitems.add(newitem);
    }
  }
}

@immutable
class Item {
  const Item ({
    required this.name,
    required this.imageprovider,
    required this.color,
    required this.intensity,
    required this.height,
    required this.width,
    required this.icons,
  });
  final String name;
  final ImageProvider imageprovider;
  final Colors color;
  final int intensity;
  final int height;
  final int width;
  final List<IconData> icons;
}
