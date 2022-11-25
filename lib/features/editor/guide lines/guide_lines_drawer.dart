import 'package:blup_task/utils/constants.dart';
import 'package:blup_task/utils/value_notifier.dart';
import 'package:flutter/material.dart';

//modal class for parsing the normal offset map to a more aptly comparable map
class CompareOffset {
  final Offset topLeft;
  final Offset topRight;

  final Offset bottomRight;
  final Offset bottomLeft;

  final Offset topMid;
  final Offset bottomMid;

  const CompareOffset({
    required this.topLeft,
    required this.topRight,
    required this.bottomRight,
    required this.topMid,
    required this.bottomMid,
    required this.bottomLeft,
  });
}

//painter class for drawing the guide lines with mentioned logic
class GuideLinesDrawer extends CustomPainter {
  Offset draggedBoxOffset;
  Map<int, Offset> originalOffsetMap;
  GuideLinesDrawer(
      {required this.draggedBoxOffset, required this.originalOffsetMap});

  //method for parsing the tempMap to a map that is proparly comparable for making the guide lines between different points
  Map<int, CompareOffset> comparisionMapMaker(Map<int, Offset> tempMap) {
    Map<int, CompareOffset> compareMap = Map();
    List<int> tempMapKeyList = tempMap.keys.toList();
    for (int i = 0; i < tempMap.length; i++) {
      compareMap[tempMapKeyList[i]] = CompareOffset(
          topLeft: tempMap[tempMapKeyList[i]]!,
          topRight: Offset(tempMap[tempMapKeyList[i]]!.dx + boxMaxWidth,
              tempMap[tempMapKeyList[i]]!.dy),
          bottomRight: Offset(tempMap[tempMapKeyList[i]]!.dx + boxMaxWidth,
              tempMap[tempMapKeyList[i]]!.dy + boxMaxWidth),
          bottomLeft: Offset(tempMap[tempMapKeyList[i]]!.dx,
              tempMap[tempMapKeyList[i]]!.dy + boxMaxHeight),
          topMid: Offset(tempMap[tempMapKeyList[i]]!.dx + (boxMaxWidth / 2),
              tempMap[tempMapKeyList[i]]!.dy),
          bottomMid: Offset(tempMap[tempMapKeyList[i]]!.dx + (boxMaxWidth / 2),
              tempMap[tempMapKeyList[i]]!.dy + boxMaxHeight));
    }
    return compareMap;
  }

  //method for the logic of guide lines painting
  void guideLinesDrawingLogic(
      Path path,
      Paint paint,
      Canvas canvas,
      Map<int, CompareOffset> boxOffsetMap,
      CompareOffset draggedComparableBoxOffset) {
    for (int i = 0; i < boxOffsetMap.length; i++) {
      List<int> compareMapKeyList = boxOffsetMap.keys.toList();

      //TODO: make sure that the offsets given to them are aligned with the actual position of the respective boxes over the screen
      //TODO: remove below drawLine
      canvas.drawLine(
          Offset(draggedComparableBoxOffset.topLeft.dx,
              draggedComparableBoxOffset.topLeft.dy),
          Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dx,
              boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dy),
          paint);

      //top left
      if (draggedComparableBoxOffset.topLeft.dy ==
          boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dy) {
        if ((draggedComparableBoxOffset.topLeft.dx -
                boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dx) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.topLeft.dx,
                  draggedComparableBoxOffset.topLeft.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.topLeft.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dx) {
        if ((draggedComparableBoxOffset.topLeft.dy -
                boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.topLeft.dx,
                  draggedComparableBoxOffset.topLeft.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.topLeft.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dx) {
        if ((draggedComparableBoxOffset.topLeft.dy -
                boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.topLeft.dx,
                  draggedComparableBoxOffset.topLeft.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.topLeft.dy ==
          boxOffsetMap[compareMapKeyList[i]]!.topRight.dy) {
        if ((draggedComparableBoxOffset.topLeft.dx -
                boxOffsetMap[compareMapKeyList[i]]!.topRight.dx) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.topLeft.dx,
                  draggedComparableBoxOffset.topLeft.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.topRight.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.topRight.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.topLeft.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.bottomMid.dx) {
        if ((draggedComparableBoxOffset.topLeft.dy -
                boxOffsetMap[compareMapKeyList[i]]!.bottomMid.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.topLeft.dx,
                  draggedComparableBoxOffset.topLeft.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomMid.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.bottomMid.dy),
              paint);
        }
      }

      //top right
      if (draggedComparableBoxOffset.topRight.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dx) {
        if ((draggedComparableBoxOffset.topRight.dy -
                boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.topRight.dx,
                  draggedComparableBoxOffset.topRight.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.topRight.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dx) {
        if ((draggedComparableBoxOffset.topRight.dy -
                boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.topRight.dx,
                  draggedComparableBoxOffset.topRight.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.topRight.dy ==
          boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dy) {
        if ((draggedComparableBoxOffset.topRight.dx -
                boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dx) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.topRight.dx,
                  draggedComparableBoxOffset.topRight.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.topRight.dy ==
          boxOffsetMap[compareMapKeyList[i]]!.topLeft.dy) {
        if ((draggedComparableBoxOffset.topRight.dx -
                boxOffsetMap[compareMapKeyList[i]]!.topLeft.dx) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.topRight.dx,
                  draggedComparableBoxOffset.topRight.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.topLeft.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.topLeft.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.topRight.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.bottomMid.dx) {
        if ((draggedComparableBoxOffset.topRight.dy -
                boxOffsetMap[compareMapKeyList[i]]!.bottomMid.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.topRight.dx,
                  draggedComparableBoxOffset.topRight.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomMid.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.bottomMid.dy),
              paint);
        }
      }

      //top mid
      if (draggedComparableBoxOffset.topMid.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dx) {
        if ((draggedComparableBoxOffset.topMid.dy -
                boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.topMid.dx,
                  draggedComparableBoxOffset.topMid.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.topMid.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dx) {
        if ((draggedComparableBoxOffset.topMid.dy -
                boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.topMid.dx,
                  draggedComparableBoxOffset.topMid.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.topMid.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.bottomMid.dx) {
        if ((draggedComparableBoxOffset.topMid.dy -
                boxOffsetMap[compareMapKeyList[i]]!.bottomMid.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.topMid.dx,
                  draggedComparableBoxOffset.topMid.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomMid.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.bottomMid.dy),
              paint);
        }
      }

      //bottom left
      if (draggedComparableBoxOffset.bottomLeft.dy ==
          boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dy) {
        if ((draggedComparableBoxOffset.bottomLeft.dx -
                boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dx) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.bottomLeft.dx,
                  draggedComparableBoxOffset.bottomLeft.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.bottomRight.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.bottomLeft.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.topRight.dx) {
        if ((draggedComparableBoxOffset.bottomLeft.dy -
                boxOffsetMap[compareMapKeyList[i]]!.topRight.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.bottomLeft.dx,
                  draggedComparableBoxOffset.bottomLeft.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.topRight.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.topRight.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.bottomLeft.dy ==
          boxOffsetMap[compareMapKeyList[i]]!.topRight.dy) {
        if ((draggedComparableBoxOffset.bottomLeft.dx -
                boxOffsetMap[compareMapKeyList[i]]!.topRight.dx) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.bottomLeft.dx,
                  draggedComparableBoxOffset.bottomLeft.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.topRight.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.topRight.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.bottomLeft.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.topLeft.dx) {
        if ((draggedComparableBoxOffset.bottomLeft.dy -
                boxOffsetMap[compareMapKeyList[i]]!.topLeft.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.bottomLeft.dx,
                  draggedComparableBoxOffset.bottomLeft.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.topLeft.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.topLeft.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.bottomLeft.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.topMid.dx) {
        if ((draggedComparableBoxOffset.bottomLeft.dy -
                boxOffsetMap[compareMapKeyList[i]]!.topMid.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.bottomLeft.dx,
                  draggedComparableBoxOffset.bottomLeft.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.topMid.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.topMid.dy),
              paint);
        }
      }

      //bottom right
      if (draggedComparableBoxOffset.bottomRight.dy ==
          boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dy) {
        if ((draggedComparableBoxOffset.bottomRight.dx -
                boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dx) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.bottomRight.dx,
                  draggedComparableBoxOffset.bottomRight.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.bottomLeft.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.bottomRight.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.topRight.dx) {
        if ((draggedComparableBoxOffset.bottomRight.dy -
                boxOffsetMap[compareMapKeyList[i]]!.topRight.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.bottomRight.dx,
                  draggedComparableBoxOffset.bottomRight.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.topRight.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.topRight.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.bottomRight.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.topLeft.dx) {
        if ((draggedComparableBoxOffset.bottomRight.dy -
                boxOffsetMap[compareMapKeyList[i]]!.topLeft.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.bottomRight.dx,
                  draggedComparableBoxOffset.bottomRight.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.topLeft.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.topLeft.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.bottomRight.dy ==
          boxOffsetMap[compareMapKeyList[i]]!.topLeft.dy) {
        if ((draggedComparableBoxOffset.bottomRight.dx -
                boxOffsetMap[compareMapKeyList[i]]!.topLeft.dx) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.bottomRight.dx,
                  draggedComparableBoxOffset.bottomRight.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.topLeft.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.topLeft.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.bottomRight.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.topMid.dx) {
        if ((draggedComparableBoxOffset.bottomRight.dy -
                boxOffsetMap[compareMapKeyList[i]]!.topMid.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.bottomRight.dx,
                  draggedComparableBoxOffset.bottomRight.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.topMid.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.topMid.dy),
              paint);
        }
      }

      //bottom mid
      if (draggedComparableBoxOffset.bottomMid.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.topRight.dx) {
        if ((draggedComparableBoxOffset.bottomMid.dy -
                boxOffsetMap[compareMapKeyList[i]]!.topRight.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.bottomMid.dx,
                  draggedComparableBoxOffset.bottomMid.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.topRight.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.topRight.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.bottomMid.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.topLeft.dx) {
        if ((draggedComparableBoxOffset.bottomMid.dy -
                boxOffsetMap[compareMapKeyList[i]]!.topLeft.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.bottomMid.dx,
                  draggedComparableBoxOffset.bottomMid.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.topLeft.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.topLeft.dy),
              paint);
        }
      }
      if (draggedComparableBoxOffset.bottomMid.dx ==
          boxOffsetMap[compareMapKeyList[i]]!.topMid.dx) {
        if ((draggedComparableBoxOffset.bottomMid.dy -
                boxOffsetMap[compareMapKeyList[i]]!.topMid.dy) <=
            minClosureLength) {
          canvas.drawLine(
              Offset(draggedComparableBoxOffset.bottomMid.dx,
                  draggedComparableBoxOffset.bottomMid.dy),
              Offset(boxOffsetMap[compareMapKeyList[i]]!.topMid.dx,
                  boxOffsetMap[compareMapKeyList[i]]!.topMid.dy),
              paint);
        }
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (editorValueNotifier.isBoxBeingDragged.value) {
      //deleting the currently dragged box's offset from the offset map so that it is not being compared with its own offsets
      Map<int, Offset> tempMap = originalOffsetMap;
      tempMap.remove(editorValueNotifier.currBoxId.value);

      //current dragged box offset in the comparable form
      late CompareOffset draggedComparableBoxOffset = CompareOffset(
          topLeft: draggedBoxOffset,
          topRight:
              Offset(draggedBoxOffset.dx + boxMaxWidth, draggedBoxOffset.dy),
          bottomRight: Offset(draggedBoxOffset.dx + boxMaxWidth,
              draggedBoxOffset.dy + boxMaxWidth),
          bottomLeft:
              Offset(draggedBoxOffset.dx, draggedBoxOffset.dy + boxMaxHeight),
          topMid: Offset(
              draggedBoxOffset.dx + (boxMaxWidth / 2), draggedBoxOffset.dy),
          bottomMid: Offset(draggedBoxOffset.dx + (boxMaxWidth / 2),
              draggedBoxOffset.dy + boxMaxHeight));

      Map<int, CompareOffset> boxOffsetMap = comparisionMapMaker(tempMap);

      Paint paint = Paint()
        ..color = Colors.pink
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 1.0;

      Path path = Path();

      guideLinesDrawingLogic(
          path, paint, canvas, boxOffsetMap, draggedComparableBoxOffset);

      canvas.drawLine(Offset(0, 0), draggedBoxOffset, paint);
    }
  }

  @override
  bool shouldRepaint(GuideLinesDrawer oldDelegate) {
    return true;
  }
}
