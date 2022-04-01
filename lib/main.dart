import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DragTest(),
    );
  }
}

class DragTest extends StatefulWidget {
  const DragTest({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DragTestState();
  }
}

class _DragTestState extends State<DragTest> {
  static double draggableWidth = 40.0, draggableHeight = 40.0;
  late Offset squarePosition;
  late Offset circlePosition;
  bool wasSquareDragged = false;
  bool wasCircleDragged = false;

  AppBar appBar = AppBar(
    title: const Text("Drag test"),
  );

  @override
  void initState() {
    super.initState();
    squarePosition = const Offset(0.0, 0.0);
    circlePosition = const Offset(0.0, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/adidas_model.png'),
              ),
            ),
          ),
          //DRAGGABLE SQUARE
          Positioned(
            left: squarePosition.dx,
            //with appbar:
            top: wasSquareDragged
                ?
                //considering we have an appbar
                squarePosition.dy -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top
                : squarePosition.dy,

            //without appbar
            //top: position.dy - height + appBarHeight,
            child: LongPressDraggable(
              childWhenDragging: const SizedBox.shrink(),
              child: GestureDetector(
                  onTap: () {
                    print("!!!!! you tapped this widget");
                  },
                  onDoubleTap: (){
                    print("!!!!! you double tapped this widget");
                  },
                  child: draggableSquare),
              feedback: draggableSquare,
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                double dx = offset.dx;
                double dy = offset.dy;

                print("DY= ${offset.dy}");
                print("DX= ${offset.dx}");
                //dx offscreen drag
                if (offset.dx.isNegative) {
                  dx = 0;
                }

                if (offset.dx >
                    MediaQuery.of(context).size.width - draggableWidth) {
                  dx = MediaQuery.of(context).size.width - draggableWidth;
                }
                //dy offscreen drag
                if (offset.dy <
                    MediaQuery.of(context).padding.top + kToolbarHeight) {
                  dy = MediaQuery.of(context).padding.top + kToolbarHeight;
                }

                if (offset.dy >
                    MediaQuery.of(context).size.height - draggableHeight) {
                  dy = MediaQuery.of(context).size.height - draggableHeight;
                }

                wasSquareDragged = true;

                setState(() {
                  squarePosition = Offset(dx, dy);
                });
              },
            ),
          ),

          //DRAGGABLE CIRCLE
          Positioned(
            left: circlePosition.dx,
            //with appbar:
            top: wasCircleDragged
                ? circlePosition.dy -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top
                : circlePosition.dy,

            //without appbar
            //top: position.dy - height + appBarHeight,
            child: LongPressDraggable(
              childWhenDragging: const SizedBox.shrink(),
              child: draggableCircle,
              feedback: draggableCircle,
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                double dx = offset.dx;
                double dy = offset.dy;

                print("DY= ${offset.dy}");
                print("DX= ${offset.dx}");
                //dx offscreen drag
                if (offset.dx.isNegative) {
                  dx = 0;
                }

                if (offset.dx >
                    MediaQuery.of(context).size.width - draggableWidth) {
                  dx = MediaQuery.of(context).size.width - draggableWidth;
                }
                //dy offscreen drag
                if (offset.dy <
                    MediaQuery.of(context).padding.top + kToolbarHeight) {
                  dy = MediaQuery.of(context).padding.top + kToolbarHeight;
                }

                if (offset.dy >
                    MediaQuery.of(context).size.height - draggableHeight) {
                  dy = MediaQuery.of(context).size.height - draggableHeight;
                }

                wasCircleDragged = true;

                setState(() {
                  circlePosition = Offset(dx, dy);
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Container draggableSquare = Container(
    child: const Icon(Icons.star, color: Colors.white),
    width: draggableWidth,
    height: draggableHeight,
    color: Colors.blue,
  );

  Container draggableCircle = Container(
    child: const Icon(Icons.ac_unit, color: Colors.white),
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.blue,
    ),
    width: draggableWidth,
    height: draggableHeight,
  );
}
