import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:video_app/git.dart';
import 'package:video_app/notifier.dart';
import 'package:video_app/size_config.dart';

import 'colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constraint, orientation);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.amber,
              canvasColor: scaffoldBackground,
              fontFamily: "RedHatDisplay",
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Dashboard(),
          );
        });
      },
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double value = 0.0;
  double? initY;

  @override
  void initState() {
    super.initState();
    _sizeNotifier = SizeNotifier();
  }

  SizeNotifier? _sizeNotifier;

  _handleDrag(details) {
    //initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    value = initY!;
  }

  _handleUpdate(details) {
    // var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    // initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    _sizeNotifier!.updateSize(initY!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeInDown(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hi, George",style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700])),
                        const Text("Dashboard",style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                      ],
                    ),
                    from: 250,
                  ),
                  FadeInDown(child: const CircleAvatar(
                      radius: 28,
                  ),
                    from: 250,
                  ),
                ],
              ),
              FadeIn(child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(24)
                ),
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    Align(alignment: Alignment.topRight,child: element()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Monitor your\nexpenses",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Spacer(),
                        TextButton(onPressed: null, child: Text("Get", style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)), style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(secondaryColor)),
                        )
                      ],
                    ),
                  ],
                ),
              ),),
              FlipInX(
                child: ChangeNotifierProvider<SizeNotifier>(
                  create: (context) => _sizeNotifier!,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 225,
                        width: double.infinity,
                        color: Colors.red,
                      ),
                      GestureDetector(
                        onVerticalDragStart: _handleDrag,
                        onVerticalDragUpdate: _handleUpdate,
                        child: Consumer<SizeNotifier>(
                            builder: (context, size, child) {
                          double val = 0.0;

                          try {
                            val = size.value / value;
                            if (val.toString() == "NaN") {
                              val = 0.0;
                            }
                          } on Exception catch (_) {
                            val = 0.0;
                          }

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: (val == 0.0)
                                ? 225
                                : val > 1.2
                                    ? 112.5
                                    : 225,
                            width: double.infinity,
                            color: Colors.grey,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: SlideInLeft(child: const StatCard(
                    title: "Profit",
                    month: "Feb",
                    percentage: "53.2%",
                  ))),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(child: SlideInRight(child: const StatCard(
                    title: "Debt",
                    month: "Mar",
                    percentage: "53.2%",
                  ))),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: null,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 72,
            width: double.infinity,
            color: scaffoldBackground,
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title, percentage, month;

  const StatCard(
      {Key? key,
      required this.title,
      required this.percentage,
      required this.month})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: cardColor, borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600]),
                  ),
                  Container(),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                percentage,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  month,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
              ),

              Container(
                height: 32,
                child: Row(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Align(
                            widthFactor: 0.8,
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: cardColor, width: 2.0)),
                            ),
                          );
                        }),
                  ],
                ),
              ),

              // Stack(
              //   children: [
              //     Container(height: 30, width: 30, decoration: BoxDecoration(
              //       color: Colors.red,
              //       shape: BoxShape.circle,
              //       border: Border.all(
              //         color: cardColor,
              //         width: 2.0
              //       )
              //     ),
              //     ),
              //     Container(height: 30, width: 30, decoration: BoxDecoration(
              //         color: Colors.red,
              //         shape: BoxShape.circle,
              //         border: Border.all(
              //             color: cardColor,
              //             width: 2.0
              //         )
              //     ),
              //     ),
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}
