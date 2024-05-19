import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jam/myFlame.dart';

List<Item> itemList = [
  Item(
      name: "name",
      color: Colors.blue,
      height: 0.2,
      width: 0,
      imageProvider: AssetImage("assets/images/welcome_rick.png"),
      icons: [
        Icons.accessibility
      ],
      intensity: 0,
      iconDisplay: false
  ),
  Item(
      name: "name",
      color: Colors.blue,
      height: 0,
      width: 0.2,
      imageProvider: AssetImage("assets/images/welcome_rick.png"),
      icons: [
        Icons.accessibility,
        Icons.abc,
        Icons.abc,
        Icons.abc,
      ],
      intensity: 0,
      iconDisplay: false
  ),
  Item(
      name: "name",
      color: Colors.blue,
      height: 0,
      width: 0,
      imageProvider: AssetImage("assets/images/welcome_rick.png"),
      icons: [
        Icons.accessibility,
        Icons.abc,
        Icons.abc,
        Icons.abc,
      ],
      intensity: 1,
      iconDisplay: false
  )
];

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
      home: MyHomePage(title: 'Flutter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Lexic lexic = Lexic();

  double acceptedData = 0;
  final MyGame myGame = MyGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildLeftDrawer(),
      endDrawer: _buildRightDrawer(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.deepOrange,
      title: Text('Make fire but be cautious not to hurt yourself'),
    );
  }

  Widget _buildLeftDrawer() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
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
    );
  }

  Widget _buildRightDrawer() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        child: ListView.builder(
          itemCount: lexic.lexicItems.length,
          itemBuilder: (BuildContext context, int index) {

            return InkWell(
              onTap: () {
                setState(() {
                  lexic.lexicItems[index].iconDisplay = !lexic.lexicItems[index].iconDisplay;
                });
              },
              child: _buildIconDisplay(index)
            );
          }
        ),
      ),
    );
  }

  Widget _buildIconDisplay(int index) {
    if (lexic.lexicItems[index].iconDisplay) {
      return SizedBox(
        child: Text(lexic.lexicItems[index].name),
      );
    } else {
      return SizedBox(
        child: Image(image: lexic.lexicItems[index].imageProvider),
      );
    }
  }

  Widget _buildBody() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: DragTarget<Item>(
        builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
            ) {
          return GameWidget<MyGame>(
            game: myGame,
          );
        },
        onAcceptWithDetails: (DragTargetDetails<Item> item) { // Used to modify the Landry's algorithm values
          setState(() {
            _updateStats(item);
          });
        },
      )
    );
  }

  Widget _buildBottomNavBar() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.10,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemList.length,
            itemBuilder:  (BuildContext context, int index) {
              return _buildDraggableItem (
                item: itemList[index],
                itemHeight: MediaQuery.of(context).size.height * 0.10 ,
                itemWidth: MediaQuery.of(context).size.height * 0.10
              );
            }
        ),
      )
    );
  }

  Widget _buildDraggableItem({
    required Item item,
    required double? itemHeight,
    required double? itemWidth
  }) {
    return Draggable<Item>(
      data: itemList[0],
      feedback: SizedBox(
          height: itemHeight,
          width: itemWidth,
          child: Image(
            image: item.imageProvider,
          )
      ),
      childWhenDragging: Image(
        image: item.imageProvider,
      ),
      child: Image(
        image: item.imageProvider,
      ),
    );
  }

  void _updateStats(DragTargetDetails<Item> item) {
    myGame.flame.height += item.data.height;
  }
}

class Lexic {
  var lexicItems = <Item>[];

  Lexic(){

    Item test = Item(
      name: "test",
      imageProvider: AssetImage("assets/images/welcome_rick.png"),
      color: Colors.red,
      intensity: 5,
      width: 10,
      height: 10,
      icons: [Icons.add, Icons.abc],
      iconDisplay: false
      );

    lexicItems.add(test);
  }

  void newLexicItem(Item newItem) {
    if (!lexicItems.contains(newItem)) {
      lexicItems.add(newItem);
    }
  }
}

class Item {
  Item ({
    required this.name,
    required this.imageProvider,
    required this.color,
    required this.intensity,
    required this.height,
    required this.width,
    required this.icons,
    required this.iconDisplay,
  });
  final String name;
  final ImageProvider imageProvider;
  final Color color;
  final double intensity;
  final double height;
  final double width;
  final List<IconData> icons;
  bool iconDisplay;
}
