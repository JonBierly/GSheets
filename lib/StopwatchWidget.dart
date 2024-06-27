import 'dart:async';
import 'package:flutter/material.dart';


class StopwatchWidget extends StatefulWidget {

  const StopwatchWidget({super.key,});

  @override
  State<StopwatchWidget> createState() => StopwatchWidgetState();
}

class StopwatchWidgetState extends State<StopwatchWidget> {
  late Stopwatch stopwatch;
  late Timer t;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    t = Timer.periodic(
      const Duration(milliseconds: 10),
      (timer) {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  void handleStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: handleStartStop,
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(150, 150),
            shape: CircleBorder(
              side: BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 3),
            ),
          ),
          child: Text(
            returnFormattedText(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                stopwatch.reset();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError),
              child: const Text("Reset"),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ],
    );
  }

  String returnFormattedText() {
    var milli = stopwatch.elapsed.inMilliseconds;
    String milliseconds = (milli % 1000).toString().padLeft(3, "0");
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");
    return "$minutes:$seconds:$milliseconds";
  }
}
