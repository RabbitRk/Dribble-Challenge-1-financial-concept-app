import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:video_app/git.dart';

import 'colors.dart';

class CardDetail extends StatefulWidget {
  @override
  _CardDetailState createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> with TickerProviderStateMixin {
  Color smallColor = Color(0xFF5859FA);
  Color bigColor = Color(0xFF8CC8DC);

  AnimationController? _controller;
  Tween<double> _tween = Tween(begin: 0.8, end: 1);

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
              const AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.elasticIn,
                  bottom: 0,
                  child: Circles(diameter: 180, color: Color(0xFF5859FA))),
              const Positioned(
                  right: 0,
                  child: Circles(diameter: 200, color: Color(0xFF8CC8DC))),
              Hero(
                tag: "card",
                child: Material(
                  color: Colors.transparent,
                  child: GlassmorphicContainer(
                    height: 193,
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
            height: 4,
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
