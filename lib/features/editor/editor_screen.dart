import 'dart:typed_data';

import 'package:blup_task/features/editor/guide%20lines/guide_lines_drawer.dart';
import 'package:blup_task/features/editor/widgets/custom_button.dart';
import 'package:blup_task/features/editor/widgets/custom_text_field.dart';
import 'package:blup_task/utils/constants.dart';
import 'package:blup_task/utils/value_notifier.dart';
import 'package:flutter/material.dart';

import 'box_layout_delegate.dart';

import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class EditorScreen extends StatefulWidget {
  EditorScreen({super.key});
  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();

  Map<int, Offset> originalMap = Map();

  //for adding textfield box adding functionality on button tap
  void _addTextButtonOnTap() {
    int len = originalMap.length;
    editorValueNotifier.currBoxId.value = len;
    editorValueNotifier.currBoxOffset.value = initialBoxPosition;
    setState(() {
      originalMap[editorValueNotifier.currBoxId.value] =
          editorValueNotifier.currBoxOffset.value;
      print(originalMap.toString());
    });
  }

  //TODO: add the app screenshot clicking functionality (and saving it in the device gallary)
  void _clickPhotoButtonOnTap() async {
    await _screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(image),
            quality: 60,
            name: "editor screen screenshot");
        print(result);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Photo has been saved in device's gallery")));
      }
    });
  }

  //for building the boxes contained in the originalMap over the editor's screen
  List<Widget>? boxesBuilder() {
    List<Widget>? boxes = [];
    List<int> boxIdList = originalMap.keys.toList();
    for (int i = 0; i < boxIdList.length; i++) {
      boxes.add(LayoutId(
          id: boxIdList[i],
          child: Stack(
            children: [
              CustomTextField(id: boxIdList[i]),
            ],
          )));
    }
    print('layout list length ------------->${originalMap.toString()}');
    return boxes;
  }

  //method for handling the onDragStart and onDragEnd logic for any box over the editor screen
  void dragLogicHandler(bool dragged) {
    /*if (editorValueNotifier.isBoxBeingDragged.value) {
      if (tempMap.containsKey(editorValueNotifier.currBoxId.value)) {
        tempMap.remove(editorValueNotifier.currBoxId.value);
        //TODO: run fn. with logic for guide lines
      }
    } else {
      if (originalMap.containsKey(editorValueNotifier.currBoxId.value)) {
        originalMap[editorValueNotifier.currBoxId.value] =
            editorValueNotifier.currBoxOffset.value;
        tempMap = originalMap;
      }
    }*/
    //TODO: verify why below code with if is not working
    /*if (editorValueNotifier.isBoxBeingDragged.value) {
      if (originalMap.containsKey(editorValueNotifier.currBoxId.value)) {
        originalMap[editorValueNotifier.currBoxId.value] = Offset(
            editorValueNotifier.currBoxOffset.value.dx - boxMaxWidth,
            editorValueNotifier.currBoxOffset.value.dy - boxMaxWidth);
      }
    }*/
    originalMap[editorValueNotifier.currBoxId.value] = Offset(
        editorValueNotifier.currBoxOffset.value.dx,
        editorValueNotifier.currBoxOffset.value.dy);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Screenshot(
        controller: _screenshotController,
        child: Scaffold(
          /*appBar: AppBar(
            title: const Text('Text Editor'),
          ),*/
          body: SizedBox(
            height: screenSize.height,
            child: Column(
              children: <Widget>[
                //the option pane:
                /*Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide())),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: CustomButton(
                            buttonText: 'Add Text',
                            buttonIcon: Icons.add,
                            onTap: _addTextButtonOnTap,
                          ),
                        ),
                        const VerticalDivider(
                          width: 10,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: CustomButton(
                            buttonText: 'Click Photo',
                            buttonIcon: Icons.photo,
                            onTap: _clickPhotoButtonOnTap,
                          ),
                        )
                      ],
                    ),
                  ),
                ),*/

                //the editor palne:
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: editorValueNotifier.isBoxBeingDragged,
                      builder: (context, value, _) {
                        print(
                            'HAS DRAGGING STARTED ---------------------------------------> ${editorValueNotifier.isBoxBeingDragged.value}');
                        dragLogicHandler(value);
                        return Stack(children: <Widget>[
                          ValueListenableBuilder(
                              valueListenable:
                                  editorValueNotifier.currBoxDragOffset,
                              builder: (context, value, _) {
                                print(
                                    'CURRENT DRAG OFFSET ------------------------------------------> ${editorValueNotifier.currBoxDragOffset.value}');
                                return CustomPaint(
                                  painter: GuideLinesDrawer(
                                      draggedBoxOffset: editorValueNotifier
                                          .currBoxDragOffset
                                          .value, //TODO: have a value listanable for listening the current dragging box offset
                                      originalOffsetMap: originalMap),
                                ); //TODO: containing the canvas over the screen all the time to show guidelines
                              }),
                          CustomMultiChildLayout(
                            delegate: BoxLayoutDelegate(
                                maxHeight: boxMaxHeight,
                                maxWidth: boxMaxWidth,
                                originalBoxMap: originalMap),
                            children: boxesBuilder() ?? [],
                          )
                        ]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
