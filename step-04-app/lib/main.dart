import 'dart:async';

import 'package:flutter/material.dart';
import 'package:starknet/starknet.dart';
import 'src/counter.sierra.g.dart';

void main(List<String> args) async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Counter counter = Counter(
        account: account0,
        address: Felt.fromHexString(const String.fromEnvironment("address")));
    return MaterialApp(
      title: 'StarkNet Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'StarkNet Demo Counter',
        counter: counter,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.counter});

  final String title;
  final Counter counter;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late Timer? _timer;
  final manager = TxManager();

  _MyHomePageState() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) => _tick());
  }

  void _tick() async {
    final value = (await widget.counter.get_counter()).toInt();
    setState(() {
      _counter = value;
    });
  }

  void _incrementCounter() async {
    final txHash = await widget.counter.tick();
    print("Transaction hash: $txHash");
    _showTransaction(txHash);
  }

  void _showTransaction(String txHash) {
    final snackBar = SnackBar(content: Text('Transaction: $txHash'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TxManager {
  void Function(String txHash)? onShowTx;
}
