import 'package:asi_authenticator/app/components/cardComponents.dart';
import 'package:asi_authenticator/app/model/Account.dart';
import 'package:asi_authenticator/app/shared/OtpGenerator.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'home_bloc.dart';
import 'home_module.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Asi Athenticator"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var blocHome = HomeModule.to.getBloc<HomeBloc>();
  // "5HTNVFARMIDCAFSXV7QBMBTJRUVIZ2TQ"
  OtpGenerator totp = OtpGenerator();

  List<String> list = List<String>.generate(1, (i) => "Item $i");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<Account>>(
        stream: blocHome.outIssuers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return CardAuth(snapshot.data[index]);
                });
          } else {
            return Center(
              child: Text("Nenhum registro encontrado"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff0063B1),
        child: Icon(Icons.add),
        onPressed: () => this.handleAddClick(),
      ),
    );
  }

  void handleAddClick() async {
    String cameraScanResult = await scanner.scan();
    this._showModalSheet('Resultado: ' + cameraScanResult);
    this.blocHome.addIssuers(cameraScanResult);
  }

  void _showModalSheet(String readQrCode) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              'QRCODE: ' + readQrCode,
              style: TextStyle(fontSize: 20),
            ),
            padding: EdgeInsets.all(40.0),
          );
        });
  }
}
