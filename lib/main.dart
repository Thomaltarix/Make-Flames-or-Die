import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'ApplicationPage.dart';

var application = ApplicationPage(title: 'Flutter Page');

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
      home: const TutorialHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TutorialHomePage extends StatefulWidget {
  const TutorialHomePage({super.key, required this.title});

  final String title;

  @override
  State<TutorialHomePage> createState() => _TutorialHomePageState();
}

class _TutorialHomePageState extends State<TutorialHomePage> {
  bool _showOverlay = true;

  @override
  void initState() {
    super.initState();
  }

  void _hideOverlayAndStartTutorial() {
    setState(() {
      _showOverlay = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TutorialManager().currentScreen),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          application,
          if (_showOverlay)
            GestureDetector(
              onTap: _hideOverlayAndStartTutorial,
              child: Container(
                color: Colors.black54,
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'assets/images/welcome_rick.png',
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.5,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          bottom: MediaQuery.of(context).size.height * 0.5,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 5,
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                        child: const Text(
                          "The Olympic Games are coming so fast!\nHelp us create and keep the flame alive!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TutorialManager {
  static final TutorialManager _instance = TutorialManager._internal();
  factory TutorialManager() => _instance;

  int _currentStep = 0;
  final List<Widget> _tutorialScreens = [
    const TutorialScreen1(),
    const TutorialScreen2(),
    application,
  ];

  TutorialManager._internal();

  int get currentStep => _currentStep;
  int get totalSteps => _tutorialScreens.length;
  Widget get currentScreen => _tutorialScreens[_currentStep];

  void nextStep(BuildContext context) {
    if (_currentStep < totalSteps - 1) {
      _currentStep++;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => currentScreen),
      );
    } else {
      reset();
    }
  }

  void reset() {
    _currentStep = 0;
  }
}

class TutorialScreen1 extends StatefulWidget {
  const TutorialScreen1({super.key});

  @override
  _TutorialScreen1State createState() => _TutorialScreen1State();
}

class _TutorialScreen1State extends State<TutorialScreen1> {
  List<TargetFocus> targets = [];
  GlobalKey keyButton = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {
    _showTutorial();
  }

  void _showTutorial() {
    targets.clear();
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: keyButton,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Text(
                "Your goal is to match the flame shown here.",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );

    TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      textSkip: "SKIP",
      paddingFocus: 10,
      onFinish: _onTutorialFinish,
      onClickTarget: _onClickTarget,
      onSkip: _onClickSkip,
    ).show(context: context);
  }

  void _onTutorialFinish() {
    TutorialManager().nextStep(context);
  }

  void _onClickTarget(TargetFocus target) {
    TutorialManager().nextStep(context);
  }

  bool _onClickSkip() {
    TutorialManager().reset();
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          application,
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                key: keyButton,
                onPressed: () {
                  // Button action
                },
                child: const Text(''),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  minimumSize: Size(50, 50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TutorialScreen2 extends StatefulWidget {
  const TutorialScreen2({super.key});

  @override
  _TutorialScreen2State createState() => _TutorialScreen2State();
}

class _TutorialScreen2State extends State<TutorialScreen2> {
  List<TargetFocus> targets = [];
  GlobalKey keyButton = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {
    _showTutorial();
  }

  void _showTutorial() {
    targets.clear();
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: keyButton,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Text(
                "Using the materials here!",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );

    TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      textSkip: "SKIP",
      paddingFocus: 10,
      onFinish: _onTutorialFinish,
      onClickTarget: _onClickTarget,
      onSkip: _onClickSkip,
    ).show(context: context);
  }

  void _onTutorialFinish() {
    TutorialManager().nextStep(context);
  }

  void _onClickTarget(TargetFocus target) {
    TutorialManager().nextStep(context);
  }

  bool _onClickSkip() {
    TutorialManager().reset();
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          application,
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                key: keyButton,
                onPressed: () {
                  // Button action
                },
                child: const Text(''),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  minimumSize: Size(50, 50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
