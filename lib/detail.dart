import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:video_app/git.dart';

import 'colors.dart';

class CardDetail extends StatefulWidget {

  final Color smallColor, bigColor;

  const CardDetail({Key? key, required this.smallColor, required this.bigColor}) : super(key: key);

  @override
  _CardDetailState createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> with TickerProviderStateMixin {

  AnimationController? _controller;
  final Tween<double> _tween = Tween(begin: 0.9, end: 1);

  int cvv = 1;
  bool animate = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity),
              Positioned(
                  bottom: 0,
                  child: Circles(diameter: 180, color: widget.smallColor)),
              Positioned(
                  right: 0,
                  child: Circles(diameter: 200, color: widget.bigColor)),
              Hero(
                tag: "card",
                child: Material(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      GlassmorphicContainer(
                        height: 224,
                        margin: const EdgeInsets.only(
                            top: 50, left: 16, right: 16, bottom: 50),
                        width: double.infinity,
                        borderRadius: 14,
                        blur: 40,
                        alignment: Alignment.bottomCenter,
                        border: 0.5,
                        linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFffffff).withOpacity(0.1),
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
                            const Color(0xFFFFFFFF).withOpacity(0.5),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/visa.svg",
                                height: 18,
                              ),
                              const SizedBox(height: 24),
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
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                     child:  Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        "06/22",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                  ),
                                   ),
                                  IndexedStack(
                                    index: cvv,
                                    alignment: Alignment.center,
                                    children: [
                                      Material(
                                        color: Colors.transparent,
                                        child: FadeIn(
                                          controller: (cc){

                                          },
                                          animate: animate,
                                          manualTrigger: true,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Text(
                                                "CVV",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "461",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      ScaleTransition(
                                          scale: _tween.animate(CurvedAnimation(
                                              parent: _controller!, curve: Curves.ease)),
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                              onTapDown: (a) {
                                                _controller!.reverse();
                                              },
                                              onTapUp: (a) {
                                                _controller!.forward();
                                                setState(() {
                                                  cvv = 0;
                                                  animate = true;
                                                });
                                              },
                                              child:  GlassmorphicContainer(
                                                height: 40,
                                                width: 80,
                                                borderRadius: 4,
                                                blur: 20,
                                                alignment: Alignment.bottomCenter,
                                                border: 0.5,
                                                linearGradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      const Color(0xFF000000).withOpacity(0.2),
                                                      const Color(0xFF000000).withOpacity(0.1),
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
                                                    const Color(0xFFFFFFFF).withOpacity(0.5),
                                                  ],
                                                ),
                                                child: const Center(
                                                  child: Text("Show CVV",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white)
                                                  ),
                                                ),
                                              )
                                          ))

                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    splashRadius: 24,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Text("Your Wallet",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SlideInLeft(
                        child: const BalanceCard(
                          title: "Balance",
                          percentage: "\$ 6,421.52",
                          month: "234",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    SlideInRight(child: SettingsCard())
                  ],
                ),
                ScaleTransition(
                    scale: _tween.animate(CurvedAnimation(
                        parent: _controller!, curve: Curves.ease)),
                    alignment: Alignment.center,
                    child: GestureDetector(
                        onTapDown: (a) {
                          _controller!.reverse();
                        },
                        onTapUp: (a) {
                          _controller!.forward();
                        },
                        child: SlideInUp(
                          child: element(),
                          from: 1000,
                        )))
              ],
            ),
          ),
        ],
      ),
    ));
  }

  @override
  dispose() {
    _controller!.dispose();
    super.dispose();
  }
}

class BalanceCard extends StatelessWidget {
  final String title, percentage, month;

  const BalanceCard(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600]),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            percentage,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: cardColor, borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          Icon(
            Icons.animation,
            color: Colors.white60,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "Settings",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class Circles extends StatelessWidget {
  final double diameter;
  final Color color;

  const Circles({Key? key, required this.diameter, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
