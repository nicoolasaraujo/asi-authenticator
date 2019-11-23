import 'dart:async';

import 'package:asi_authenticator/app/model/KeyUri.dart';
import 'package:asi_authenticator/app/shared/OtpGenerator.dart';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';

import 'Countdown.dart';

class CardAuth extends StatefulWidget {
  final UriKey issuer;
  CardAuth(this.issuer);
  @override
  _CardAuthState createState() => _CardAuthState();
}

class _CardAuthState extends State<CardAuth> with TickerProviderStateMixin {
  String value;
  AnimationController _controller;
  final int initialValue = 10;
  OtpGenerator opt = OtpGenerator();

  @override
  void initState() {
    super.initState();
    this.reset();

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
    Timer.periodic(
        Duration(seconds: this.initialValue), (Timer t) => this.reset());
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

  reset() {
    setState(() {
      var result = this
          .opt
          .getTOTP("5HTNVFARMIDCAFSXV7QBMBTJRUVIZ2TQ", 1362302550000);

      this.value =
          result.substring(0, 3) + ' ' + result.substring(3, result.length);

      var otpResult = OTP.generateTOTPCode("JBSWY3DPEHPK3PXP", 1362302550000);
      print(otpResult);
    });
  }
}
