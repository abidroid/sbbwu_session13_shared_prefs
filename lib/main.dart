import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tasbeeh App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // initial state
  // private variable
  int _counter = 0;

  @override
  void initState() {
    readCounterFromSP();
    super.initState();
  }


  void _incrementCounter() async {

    print('tap done');
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _counter++;
    });

    prefs.setInt('counter', _counter);
  }

  readCounterFromSP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? storedValue = prefs.getInt('counter');

    setState(() {
      _counter = storedValue ?? 0;
    });

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
        
        actions: [
          IconButton(onPressed: (){

            setState(() {
              _counter = 0;
            });

          }, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: GestureDetector(
        onTap: _incrementCounter,
        child: Container(
          color: Colors.amber,
          child: Center(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
