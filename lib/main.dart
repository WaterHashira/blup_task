import 'package:blup_task/features/editor/box_layout_delegate.dart';
import 'package:blup_task/features/editor/editor_screen.dart';
import 'package:blup_task/features/editor/widgets/custom_text_field.dart';
import 'package:blup_task/utils/constants.dart';
import 'package:blup_task/utils/value_notifier.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//TODO: make it stateful
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Offset> originalMap = {};

    //for adding textfield box adding functionality on button tap
    void _addTextButtonOnTap() {
      int len = originalMap.length;
      print(len);
      //EditorScreen().currBoxId = len;
      //EditorScreen().currBoxOffset = initialBoxPosition;
      setState(() {
        originalMap[len] = initialBoxPosition;
        print(originalMap.toString());
        //tempMap = originalMap;
      });
    }

    //for building the boxes contained in the originalMap over the editor's screen
    List<Widget> boxesBuilder() {
      List<Widget> boxes = [];
      List<int> boxIdList = originalMap.keys.toList();
      for (int i = 0; i < boxIdList.length; i++) {
        boxes.add(LayoutId(
            id: boxIdList[i],
            child: Stack(
              children: [
                CustomTextField(
                  id: boxIdList[i],
                ),
              ],
            )));
      }
      return boxes;
    }

    //method for handling the onDragStart and onDragEnd logic for any box over the editor screen
    void dragLogicHandler(bool dragged) {
      if (dragged) {
        /*if (tempMap.containsKey(widget.currBoxId)) {
        tempMap.remove(widget.currBoxId);
        //run fn. with logic for guide lines*/
      } else {
        //originalMap[EditorScreen().currBoxId] = EditorScreen().currBoxOffset;
        //tempMap = originalMap;
      }
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: EditorScreen(),
      /*Scaffold(
        floatingActionButton:
            FloatingActionButton(onPressed: _addTextButtonOnTap),
        body: Container(
            child: ValueListenableBuilder(
          valueListenable: EditorValueNotifier().isBoxBeingDragged,
          builder: (context, value, _) {
            print(
                'called again ----------------------> val -------> ${EditorValueNotifier().isBoxBeingDragged.value}');
            dragLogicHandler(value);
            return Stack(
              children: [
                Container(),
                CustomMultiChildLayout(
                  delegate: BoxLayoutDelegate(
                      maxHeight: 200,
                      maxWidth: 200,
                      originalBoxMap: originalMap),
                  children: boxesBuilder(),
                ),
              ],
            );
          },
        )),
      ),*/
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
