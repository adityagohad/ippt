import 'package:flutter/material.dart';
import 'package:ippt/ippt_canvas.dart';
import 'package:ippt/utils/screen_ratio.dart';

class IpptBuilder extends StatefulWidget {
  const IpptBuilder({super.key});

  @override
  State<IpptBuilder> createState() => _IpptBuilderState();
}

class _IpptBuilderState extends State<IpptBuilder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: const BottomAppBar(),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.red,
                )),
            Expanded(
                flex: 7,
                child: Container(
                  color: Theme.of(context).canvasColor,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: AspectRatio(
                      aspectRatio: ScreenRatio.mobile1.value,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 10),
                                  blurRadius: 30,
                                  spreadRadius: 10,
                                  color: Theme.of(context).shadowColor)
                            ]),
                        child: const IpptCanvas(),
                      ),
                    ),
                  )),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  color: Colors.blue,
                ))
          ],
        ));
  }
}
/*

*/