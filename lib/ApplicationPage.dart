import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jam/myFlame.dart';
import 'dart:math' as math;

List<Item> itemList = [
  Item(
      name: "Matches",
      color: Colors.transparent,
      height: 0,
      width: 0,
      imagePath: "assets/images/lit.png",
      icons: [
        Icons.local_fire_department
      ],
      intensity: 0,
      iconDisplay: false
  ),
  Item(
      name: "Logs",
      color: Colors.transparent,
      height: 0,
      width: 0.25,
      imagePath: "assets/images/log.png",
      icons: [
      ],
      intensity: 0,
      iconDisplay: false
  ),
  Item(
      name: "Branches",
      color: Colors.transparent,
      height: 0.25,
      width: 0,
      imagePath: "assets/images/branch.png",
      icons: [
      ],
      intensity: 0,
      iconDisplay: false
  ),
  Item(
      name: "Salt",
      color: Colors.yellow,
      height: 0,
      width: 0,
      imagePath: "assets/images/jaune.png",
      icons: [
      ],
      intensity: 0,
      iconDisplay: false
  ),
  Item(
      name: "Hand sanitizer",
      color: Colors.blue,
      height: 0,
      width: 0,
      imagePath: "assets/images/bleu.png",
      icons: [
      ],
      intensity: 0,
      iconDisplay: false
  ),
  Item(
      name: "Landry",
      color: Colors.green,
      height: 0,
      width: 0,
      imagePath: "assets/images/landry-vert.png",
      icons: [
      ],
      intensity: 0,
      iconDisplay: false
  ),
  Item(
      name: "Lithium battery",
      color: Colors.red,
      height: 0,
      width: 0,
      imagePath: "assets/images/rouge.png",
      icons: [
      ],
      intensity: 0,
      iconDisplay: false
  ),
  Item(
      name: "Fertilizer",
      color: Colors.purple,
      height: 0,
      width: 0,
      imagePath: "assets/images/violet.png",
      icons: [
      ],
      intensity: 0,
      iconDisplay: false
  ),
  Item(
      name: "Air",
      color: Colors.transparent,
      height: 0,
      width: 0,
      imagePath: "assets/images/r.png",
      icons: [
      ],
      intensity: 1,
      iconDisplay: false
  ),
  Item(
      name: "Are you sure about that ?",
      color: Colors.transparent,
      height: 40,
      width: 25,
      imagePath: "assets/images/boom.png",
      icons: [
      ],
      intensity: 75,
      iconDisplay: false
  ),
  Item(
      name: "You already know",
      color: Colors.pink,
      height: 1,
      width: 1,
      imagePath: "assets/images/cursed.png",
      icons: [
      ],
      intensity: 0,
      iconDisplay: false
  )
];


int randomIntValue(int max) {
  return math.Random().nextInt(max);
}

class ApplicationPage extends StatefulWidget {
  ApplicationPage({super.key, required this.title});

  final String title;

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  Lexic lexic = Lexic();

  double acceptedData = 0;
  final MyGame myGame = MyGame(1,  1, Colors.red, 3);
  final MyGame result = MyGame(randomValueBetween(0.5, 5), randomValueBetween(0.5, 5), Color.fromARGB(255, randomIntValue(255), randomIntValue(255), randomIntValue(255)), randomIntValue(4) + 1);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(),
          drawer: _buildLeftDrawer(),
          endDrawer: _buildRightDrawer(),
          body: _buildBody(),
          bottomNavigationBar: _buildBottomNavBar(),
        ),
      ],
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
              onTap: (){},
            ),
            ListTile(
              title: Text('Settings'),
              onTap: (){},
            ),
            ListTile(
              title: Text('Help'),
              onTap: (){},
            ),
            ListTile(
              title: Text('Credits'),
              onTap: (){},
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
        child: Image.asset(lexic.lexicItems[index].imagePath),
      );
    }
  }

  Widget _buildBody() {
    return Stack(
      children: [
        SizedBox(
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
              onAcceptWithDetails: (DragTargetDetails<Item> item) {
                setState(() {
                  _updateStats(item);
                });
              },
            )
        ),
        Container(
          color: Colors.deepOrange.withOpacity(1),
          height: MediaQuery.of(context).size.height * 0.3 + 1,
          width: MediaQuery.of(context).size.width * 0.3 + 1,
          child: GameWidget<MyGame>(
            game: result,
          ),
        )
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return Padding(
        padding: EdgeInsets.all(50),
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
      data: item,
      feedback: SizedBox(
        height: itemHeight,
        width: itemWidth,
        child: Image.asset(item.imagePath),
      ),
      childWhenDragging: Image.asset(item.imagePath),
      child: Image.asset(item.imagePath),
    );
  }

  void _updateStats(DragTargetDetails<Item> item) {
    myGame.flame.height += item.data.height;
    myGame.flame.width += item.data.width;
    myGame.flame.intensity += item.data.intensity;
    if (item.data.color != Colors.transparent) {
      int red = (myGame.flame.color.red + item.data.color.red) ~/ 2;
      int green = (myGame.flame.color.green + item.data.color.green) ~/ 2;
      int blue = (myGame.flame.color.blue + item.data.color.blue) ~/ 2;
      myGame.flame.color =  Color.fromARGB(255, red, green, blue);
    }
  }
}

class Lexic {
  var lexicItems = <Item>[];

  Lexic(){

    Item test = Item(
        name: "test",
        imagePath: "assets/images/welcome_rick.png",
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
    required this.imagePath,
    required this.color,
    required this.intensity,
    required this.height,
    required this.width,
    required this.icons,
    required this.iconDisplay,
  });
  final String name;
  final String imagePath;
  final Color color;
  final int intensity;
  final double height;
  final double width;
  final List<IconData> icons;
  bool iconDisplay;
}
