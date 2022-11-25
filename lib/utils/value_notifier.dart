import 'package:blup_task/utils/constants.dart';
import 'package:flutter/material.dart';

class EditorValueNotifier with ChangeNotifier {
  //a notifier to let know that the dragging event has started
  ValueNotifier<bool> isBoxBeingDragged = ValueNotifier<bool>(false);

  ValueNotifier<int> currBoxId = ValueNotifier<int>(
      0); //id of last box that have been created or box that is currently being dragged

  ValueNotifier<Offset> currBoxOffset = ValueNotifier<Offset>(
      initialBoxPosition); //current offset of last box that have been created or box that has just been dragged to a new position

  ValueNotifier<Offset> currBoxDragOffset = ValueNotifier<Offset>(
      initialBoxPosition); //current offset of the box that is currently being dragged
}

EditorValueNotifier editorValueNotifier = EditorValueNotifier();
