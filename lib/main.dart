import 'package:flutter/material.dart';

List<Item> itemList = [
  Item(
    name: "name",
    color: Colors.blue,
    height: 4,
    width: 4,
    imageProvider: AssetImage("assets/images/welcome_rick.png"),
    icons: [
      Icons.accessibility
    ],
    intensity: 5
  ),
  Item(
      name: "name",
      color: Colors.blue,
      height: 4,
      width: 4,
      imageProvider: AssetImage("assets/images/welcome_rick.png"),
      icons: [
        Icons.accessibility,
        Icons.abc,
        Icons.abc,
        Icons.abc,
      ],
      intensity: 5
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

  final GlobalKey _draggableKey = GlobalKey();

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
              return Row(
                children: [
                  Image(image: lexic.lexicItems[index].imageProvider),
                  Text(lexic.lexicItems[index].name),
                  ListView.builder(
                      itemCount: lexic.lexicItems[index].icons.length,
                      itemBuilder: (BuildContext context, int ind_2) {
                        return Icon(lexic.lexicItems[index].icons[ind_2]);
                      }
                  ),
                ],
              );
            }
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.10,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemList.length,
          itemBuilder:  (BuildContext context, int index) {
            return _buildDraggableItem (
                item: itemList[index]
            );
          }
      ),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _buildDraggableItem({
    required Item item
  }) {
    return LongPressDraggable<Item>(
      data: item,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: DraggingListItem(
        dragKey: _draggableKey,
        imageProvider: item.imageProvider,
      ),
      child: MenuListItem(
        imageProvider: item.imageProvider
      )
    );
  }
}

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    super.key,
    required this.imageProvider
  });
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: imageProvider,
    );
  }
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.imageProvider
  });

  final GlobalKey dragKey;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12),
        child: Image(
          image: imageProvider
        )
      ),
    );
  }
}

class Lexic {
  var lexicItems = <Item>[];

  Lexic();

  void newLexicItem(Item newItem) {
    if (!lexicItems.contains(newItem)) {
      lexicItems.add(newItem);
    }
  }
}

@immutable
class Item {
  Item ({
    required this.name,
    required this.imageProvider,
    required this.color,
    required this.intensity,
    required this.height,
    required this.width,
    required this.icons,
  });
  final String name;
  final ImageProvider imageProvider;
  final Color color;
  final int intensity;
  final int height;
  final int width;
  final List<IconData> icons;
}
