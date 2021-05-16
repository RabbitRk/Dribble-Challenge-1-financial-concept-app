import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Init(),
    );
  }
}

class Init extends StatefulWidget {
  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureProvider<MyModel>(
          initialData: MyModel(someValue: 'defaultValue'),
          create: (context) => networkcalls(),
          child: Column(
            children: [
              Consumer<MyModel>(
                  builder: (context, myModel, child){
                    return Text(myModel.someValue);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}


Future<MyModel> networkcalls() async {
  await Future.delayed(Duration(seconds: 5));
  return MyModel(someValue: 'new data');
}

class MyModel {
  MyModel({ required this.someValue});
  String someValue = 'Hello';
  Future<void> doSomething() async {
    await Future.delayed(Duration(seconds: 2));
    someValue = 'Goodbye';
    print(someValue);
  }
}