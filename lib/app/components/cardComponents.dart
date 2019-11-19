import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CardAuth extends StatefulWidget {
  @override
  _CardAuthState createState() => _CardAuthState();
}

class _CardAuthState extends State<CardAuth> with TickerProviderStateMixin {
  String value;
  AnimationController _controller;
  final int initialValue = 10;

  @override
  void initState() {
    super.initState();
    this.value = Random().nextInt(100).toString() +
        ' ' +
        Random().nextInt(100).toString();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: initialValue),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        status = AnimationStatus.forward;
        this._controller.repeat().then(this.reset());
      }
    });
    _controller.forward(from: 3);

    var oneSec = Duration(seconds: this.initialValue);
    Timer.periodic(oneSec, (Timer t) => this.reset());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(25),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    this.value,
                    style: TextStyle(color: Color(0xff0063B1), fontSize: 25), 
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: new Countdown(
                    animation: new StepTween(
                      begin: this.initialValue,
                      end: 0,
                    ).animate(_controller),
                  ),
                ),
              )
            ],
          ),
        ),
        elevation: 5,
      ),
    );
  }

  void resetx() {
    setState(() {
      this._controller.value = this.initialValue.roundToDouble();
    });
  }

  reset() {
    print('set state');
    setState(() {
      // this._controller.forward(period: Duration(seconds: initialValue));
      this.value = Random().nextInt(100).toString() +
          ' ' +
          Random().nextInt(100).toString() +
          ' ' +
          Random().nextInt(100).toString() +
          ' ' +
          Random().nextInt(100).toString() +
          ' ' +
          Random().nextInt(100).toString() +
          ' ' +
          Random().nextInt(100).toString();
    });
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    return new Text(
      animation.value.toString(),
      style: new TextStyle(fontSize: 22.0),
    );
  }
}
