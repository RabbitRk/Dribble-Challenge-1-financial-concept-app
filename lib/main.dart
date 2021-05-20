import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:video_app/detail.dart';
import 'package:video_app/notifier.dart';
import 'package:video_app/routes.dart';
import 'package:video_app/size_config.dart';

import 'colors.dart';
import 'git.dart';

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
            onGenerateRoute: Routes.generateRoute,
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

  bool data = false;

  @override
  void initState() {
    super.initState();
    _sizeNotifier = SizeNotifier();
  }

  SizeNotifier? _sizeNotifier;

  _handleDrag(DragStartDetails details) {
    //initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;

    print("data:  " + initY.toString());
  }

  _handleUpdate(DragUpdateDetails details) {
    // var dx = details.globalPosition.dx - initX;
    //var dy = details.delta.dy - initY;
    // initX = details.globalPosition.dx;
    value = details.globalPosition.dy - initY!;
    print("======" + value.toString());
    _sizeNotifier!.updateSize(value);
  }

  _handleEnd() {
    setState(() {
      data = !data;
    });
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
                        Text("Hi, George",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[600])),
                        const Text("Dashboard",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ],
                    ),
                    from: 250,
                  ),
                  FadeInDown(
                    child: const CircleAvatar(
                      radius: 28,
                    ),
                    from: 250,
                  ),
                ],
              ), //Image.asset("assets/saly.png", fit: BoxFit.contain,)
              FadeIn(
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(24)),
                  padding:
                      const EdgeInsets.only(top: 16.0, right: 16, left: 16),
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            "assets/saly.png",
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Monitor your\nexpenses",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: TextButton(
                              onPressed: null,
                              child: const Text("Get",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0))),
                                  backgroundColor: MaterialStateProperty.all(
                                      secondaryColor)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              FlipInX(
                child: ChangeNotifierProvider<SizeNotifier>(
                  create: (context) => _sizeNotifier!,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      GlassmorphicContainer(
                        height: 225,
                        width: double.infinity,
                        borderRadius: 24,
                        blur: 20,
                        alignment: Alignment.bottomCenter,
                        border: 0,
                        linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF2D3235).withOpacity(0.9),
                              Color(0xFF292D30).withOpacity(0.5),
                            ],
                            stops: const [
                              0.1,
                              1,
                            ]),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFA8A8A8).withOpacity(1),
                            Color(0xFFFFFFFF).withOpacity(0.5),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 225,
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          children: const [
                            CreditCard(
                                smallColor: Color(0xFF5859FA),
                                bigColor: Color(0xFF8CC8DC)),
                            CreditCard(
                                smallColor: Color(0xFFC07021),
                                bigColor: Color(0xFFEEB40B)),
                            CreditCard(
                                smallColor: Colors.lightGreenAccent,
                                bigColor: Colors.green),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onVerticalDragStart: (d) => _handleDrag(d),
                        onVerticalDragUpdate: (d) => _handleUpdate(d),
                        onVerticalDragEnd: (d) => _handleEnd(),
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
                            duration: const Duration(milliseconds: 160),
                            height: size.value > 50 ? 112.5 : 225,
                            width: double.infinity,
                            child: GlassmorphicContainer(
                              height: 225,
                              width: double.infinity,
                              borderRadius: (size.value < 50) ? 24 : 16,
                              blur: 20,
                              alignment: Alignment.bottomCenter,
                              border: 0,
                              linearGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFFffffff).withOpacity(0.09),
                                    const Color(0xFFFFFFFF).withOpacity(0.1),
                                  ],
                                  stops: const [
                                    0.1,
                                    1,
                                  ]),
                              borderGradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFFffffff).withOpacity(0.5),
                                  const Color((0xFFFFFFFF)).withOpacity(0.5),
                                ],
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    touchElement(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Balance",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey),
                                            ),
                                            Text("\$ 6,421.52",
                                                style: TextStyle(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        TextButton(
                                          onPressed: null,
                                          child: const Text("See more",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white)),
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0))),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      secondaryColor)),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: AnimatedOpacity(
                                        opacity: size.value > 50 ? 0 : 1,
                                        duration:
                                            const Duration(milliseconds: 100),
                                        child: ListView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: [
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: const [
                                                Text("23 March",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey)),
                                                Text("\$813",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey)),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 44,
                                                  width: 44,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF2B2F33),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0)),
                                                  child: const Icon(
                                                    Icons.animation,
                                                    color: Colors.white60,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: const [
                                                      Text("ATM, 375 Canal St",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Colors
                                                                  .white)),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text("Cash withdrawal",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.grey)),
                                                    ],
                                                  ),
                                                ),
                                                const Text("-\$ 300",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
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
                  Expanded(
                      child: SlideInLeft(
                          child: const StatCard(
                    title: "Profit",
                    month: "Feb",
                    percentage: "53.2%",
                  ))),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                      child: SlideInRight(
                          child: const StatCard(
                    title: "Debt",
                    month: "Mar",
                    percentage: "53.2%",
                  ))),
                ],
              ),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: const FloatingActionButton(
        //   backgroundColor: secondaryColor,
        //   onPressed: null,
        // ),
        // bottomNavigationBar: BottomAppBar(
        //   child: Container(
        //     height: 72,
        //     width: double.infinity,
        //     color: scaffoldBackground,
        //   ),
        // ),
      ),
    );
  }

  Widget touchElement() {
    return Opacity(
      opacity: 0.5,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        height: 4,
        width: 38,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
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
              SizedBox(
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
                            widthFactor: 0.6,
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: cardColor, width: 3.0)),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  final Color smallColor, bigColor;

  const CreditCard({Key? key, required this.smallColor, required this.bigColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (pu) {
        if (pu.delta.dy < 0) {
          Navigator.pushNamed(context, Routes.CardDetail_,
              arguments: {"smallColor": smallColor, "bigColor": bigColor});
        }
      },
      child: Hero(
        tag: "card",
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Stack(
            children: [
              Positioned(
                  left: 0,
                  top: 50,
                  child: Circles(diameter: 120, color: smallColor)),
              Positioned(
                  right: 0,
                  top: -50,
                  child: Circles(diameter: 200, color: bigColor)),
              GlassmorphicContainer(
                height: 193,
                width: double.infinity,
                borderRadius: 14,
                blur: 30,
                alignment: Alignment.bottomCenter,
                border: 0.5,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.1),
                      Color(0xFFFFFFFF).withOpacity(0.1),
                    ],
                    stops: const [
                      0.1,
                      1,
                    ]),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFffffff).withOpacity(0.5),
                    Color(0xFFFFFFFF).withOpacity(0.5),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/visa.svg",
                      height: 18,
                    ),
                    const SizedBox(height: 8),
                    const Material(
                      color: Colors.transparent,
                      child: Text(
                        "**** **** **** 6584",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
