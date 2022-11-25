import 'package:blup_task/features/editor/editor_screen.dart';
import 'package:blup_task/utils/constants.dart';
import 'package:blup_task/utils/value_notifier.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final int id;
  const CustomTextField({super.key, required this.id});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color borderColor = Colors.black;
  bool showNudge = false;

  void boxSelected() {
    setState(() {
      borderColor = Colors.blue;
      showNudge = true;
    });
  }

  void boxOriginalConfig() {
    setState(() {
      borderColor = Colors.black;
      showNudge = false;
    });
  }

  Widget textFieldBuilder() {
    return Material(
      child: SizedBox(
        child: Column(
          children: [
            Container(
              height: boxMaxHeight - 10,
              width: boxMaxWidth,
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
              ),
              child: TextField(
                onTap: boxSelected,
                //maxLines: null,
              ),
            ),
            (showNudge)
                ? Center(
                    child: Container(
                      height: 10,
                      width: 15,
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  EditorScreen editorScreen = EditorScreen();

//TODO: fix the length and width values here
  @override
  Widget build(BuildContext context) {
    return Draggable(
        feedback: textFieldBuilder(), //TODO: change this accordingly
        onDragStarted: () {
          editorValueNotifier.currBoxId.value = widget.id;
          editorValueNotifier.isBoxBeingDragged.value = true;
          editorValueNotifier.notifyListeners();
          boxSelected();
        },
        onDragUpdate: (details) {
          final box = context.findRenderObject() as RenderBox;
          final point = box.globalToLocal(details.globalPosition);
          print(point);
          editorValueNotifier.currBoxDragOffset.value = point;
          editorValueNotifier.notifyListeners();
        },
        onDragEnd: (details) {
          print('drag end offset-------------> ${details.offset}');
          final box = context.findRenderObject() as RenderBox;
          final point = box.globalToLocal(details.offset);
          editorValueNotifier.currBoxOffset.value = point;
          editorValueNotifier.isBoxBeingDragged.value = false;
          editorValueNotifier.notifyListeners();
          boxOriginalConfig();
        },
        child: textFieldBuilder());
  }
}
