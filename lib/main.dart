import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
