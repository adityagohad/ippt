import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          height: 100,
          width: 100,
          // height: height,
          // width: height * ScreenRatio.mobile1.value,
          color: Colors.red,
          child: Stack(
            children: [
              SizedBox(
                width: 10,
                height: 10,
                child: Container(
                  width: 10,
                  height: 10,
                  color: Colors.amber,
                ),
              )
            ],
          ),
        ));
  }
}
