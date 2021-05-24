import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterPlugin {
  static const MethodChannel _channel = const MethodChannel('flutter_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

Widget defaultHeader = Container();

class HiddenDrawer extends StatefulWidget {
  final List<Widget> items;
  final Color drawerBackgroundColor;
  final Color drawerColor;
  final Color backgroundColor;
  final Color dividerColor;
  final double dividerDensity;
  final double dividerLength;
  final double x;
  final double rotateX;
  final double y;
  final Duration duration;
  final Widget header;
  final double rotateY;
  final double scale;
  final double z;
  final double borderRadius;
  final Widget child;
  const HiddenDrawer({
    Key key,
    @required this.items,
    this.drawerColor,
    this.dividerColor,
    this.dividerDensity,
    this.dividerLength,
    @required this.child,
    this.drawerBackgroundColor,
    this.backgroundColor,
    this.x = 200,
    this.y = 200,
    this.scale = 0.7,
    this.borderRadius = 50,
    this.rotateX = 0,
    this.rotateY = 0,
    this.z = 0,
    @required this.duration,
    this.header,
  }) : super(key: key);
  @override
  _HiddenDrawerState createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  double xOffset = 0;
  double yOffset = 0;
  double zOffset = 0;
  double rX = 0;
  double rY = 0;
  double scaleFactor = 1;
  double radius = 0;
  bool isDOpen = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          color: widget.drawerBackgroundColor,
          height: screenHeight,
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.header != null ? widget.header : Container(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.items.length,
                      itemBuilder: (ctx, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(child: widget.items[index]),
                            Container(
                              color: widget.dividerColor,
                              height: widget.dividerDensity,
                              width: widget.dividerLength,
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container()
            ],
          ),
        ),
        GestureDetector(
          onPanUpdate: (data) {
            if (data.delta.dx > 0 && data.delta.dy < 0) {
              setState(() {
                xOffset = widget.x;
                yOffset = widget.y;
                scaleFactor = widget.scale;
                radius = widget.borderRadius;
                rX = widget.rotateX;
                rY = widget.rotateY;
                zOffset = widget.z;
                isDOpen = true;
              });
            }
            if (data.delta.dx < 0 && data.delta.dy > 0) {
              setState(() {
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                radius = 0;
                rX = 0;
                rY = 0;
                zOffset = 0;
                isDOpen = false;
              });
            }
          },
          child: AnimatedContainer(
            duration: widget.duration,
            transform: Matrix4.translationValues(xOffset, yOffset, zOffset)
              ..scale(scaleFactor)
              ..rotateX(rX)
              ..rotateY(rY),
            decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(radius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 20,
                    blurRadius: 100,
                  )
                ]),
            height: screenHeight,
            width: screenWidth,
            child: Column(
              children: [
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: isDOpen
                        ? IconButton(
                            icon: Icon(
                              Icons.open_in_full,
                              color: widget.drawerColor,
                            ),
                            onPressed: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                scaleFactor = 1;
                                radius = 0;
                                rX = 0;
                                rY = 0;
                                zOffset = 0;
                                isDOpen = false;
                              });
                            })
                        : IconButton(
                            icon: Icon(Icons.menu_outlined),
                            onPressed: () {
                              setState(() {
                                xOffset = widget.x;
                                yOffset = widget.y;
                                scaleFactor = widget.scale;
                                radius = widget.borderRadius;
                                rX = widget.rotateX;
                                rY = widget.rotateY;
                                zOffset = widget.z;
                                isDOpen = true;
                              });
                            }),
                  ),
                ),
                widget.child,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
