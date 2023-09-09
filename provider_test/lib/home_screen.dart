import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/provider_file.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text(' Single Provider Example Counter'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CountProvider>(
              builder: (context, value, child) {
                return Text('Value: ${value.count}',style: TextStyle(fontSize: 40),);
              },
            ),
            Gap(20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CountProvider>(context, listen: false)
                        .startIncrement();
                  },
                  child: const Text('Start Increment'),
                ),
                Gap(20),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CountProvider>(context, listen: false)
                        .startDecrement();
                  },
                  child: const Text('Start Decrement'),
                ),
                Gap(20),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CountProvider>(context, listen: false)
                        .stopIncrement();
                  },
                  child: Text('Stop CountDown'),
                ),
                Gap(20),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CountProvider>(context, listen: false)
                        .resetValue();
                  },
                  child: Text('Reset CountDown'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
