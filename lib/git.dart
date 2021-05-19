import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 50),
      vsync: this,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller!.repeat();
      }
    });

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Offset _offset = Offset(0.3, -0.9);
    timeDilation = 2.0;

    // final _height = ScreenQueries.instance.height(context);
    // final _width = ScreenQueries.instance.width(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF050303),
      body: Center(
        child: Transform(
          alignment: FractionalOffset.centerLeft,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0011)
            ..rotateX(_offset.dy)
            ..rotateY(_offset.dx),
          child: RotationTransition(
            turns: _controller!,
            child: Image.network(
              'https://scx2.b-cdn.net/gfx/news/hires/2019/galaxy.jpg',
              fit: BoxFit.contain,
              // height: _height,
              // width: _width,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        label: const Text('Back'),
        icon: const Icon(Icons.arrow_back),
        backgroundColor: Colors.black,
      ),
    );
  }
}

// class element extends StatefulWidget {
//   final Color color;
//
//   const element({Key? key, this.color = Colors.red}) : super(key: key);
//
//   @override
//   _elementState createState() => _elementState();
// }
//
// class _elementState extends State<element> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(height: 50,width: 50, color: widget.color,);
//   }
// }

class element extends StatelessWidget {
  final Color color;

  element({Key? key, this.color = Colors.red}) : super(key: key);
  @override
  Widget build(BuildContext context) {
return Container(margin: const EdgeInsets.all(5.0),height: 50,width: 50, color: color,);
  }
}



class SlideRightRoute extends PageRouteBuilder {
  final Widget? page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page!,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

class FadeRoute extends PageRouteBuilder {
  final Widget? page;
  FadeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page!,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}

class SlideLeftRoute extends PageRouteBuilder {
  final Widget? page;
  SlideLeftRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page!,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

class SlideTopRoute extends PageRouteBuilder {
  final Widget? page;
  SlideTopRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page!,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
  );
}

class SlideBottomRoute extends PageRouteBuilder {
  final Widget? page;
  SlideBottomRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page!,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}
