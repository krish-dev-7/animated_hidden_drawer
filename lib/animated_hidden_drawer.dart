import 'package:flutter/material.dart';

/// As I build this plugin from scratch,
///
/// i didn't used any other plugin :)
// class FlutterPlugin {
//   static const MethodChannel _channel = const MethodChannel('flutter_plugin');
//
//   static Future<String> get platformVersion async {
//     final String version = await _channel.invokeMethod('getPlatformVersion');
//     return version;
//   }
// }

class HiddenDrawer extends StatefulWidget {
  final List<Widget> items;

  /// add list of widgets with Gesture detector with changeable screens
  ///
  /// **must required**
  final Color drawerBackgroundColor;

  /// drawer background color
  ///
  /// optional

  final Color drawerColor;

  /// drawer icon color
  ///
  /// optional
  final Color backgroundColor;

  /// this gives the background colour
  ///
  /// for the app bar and bottom bar
  ///
  final Color dividerColor;

  /// colour for divider
  ///
  /// actually this is a container
  ///
  /// optional
  final double dividerDensity;

  /// it is the width of the divider
  ///
  /// which is height of the container
  ///
  /// **optional**
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

  /// this child takes Widget and provides the screen for our app
  /// ...
  ///
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

    /// Below fields with default values
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
                      /// This provides the list view
                      /// ... xD
                      /// among the given list of widget items
                      shrinkWrap: true,
                      itemCount: widget.items.length,
                      itemBuilder: (ctx, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(child: widget.items[index]),
                            Container(
                              /// This container acts as a divider line
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
            /// This gesture detection is for
            /// ...f
            /// showing the drawer items when we swipe
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
            /// this class plays vital role for this animation
            /// :) xD
            /// yup
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

                        /// If Drawer opened then icons is open_in_full
                        /// ...
                        /// or else menu_outlined for classification
                        /// ...
                        ///this bool plays vital role to check for condition for
                        /// whether the drawer
                        /// is opened
                        /// or not
                        ? IconButton(
                            icon: Icon(
                              Icons.open_in_full,
                              color: widget.drawerColor,
                            ),
                            onPressed: () {
                              /// if drawer opened ,then on next press
                              /// ...
                              /// we should resize accordingly
                              /// ...
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
                              /// if drawer not opened ,then on next press
                              /// ...
                              /// we should resize accordingly
                              /// ...
                              /// this gives attraction
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
