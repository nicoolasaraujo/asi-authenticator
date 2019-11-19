import 'package:asi_authenticator/app/app_module.dart';
import 'package:asi_authenticator/app/components/cardComponents.dart';
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
  List<String> list = List<String>.generate(5, (i) => "Item $i");
  @override
  void initState(){
    // this.blocHome.initializeState();
    // this.blocHome.initializeState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: this.list.length,
        itemBuilder: (context, index){
          return CardAuth();
        },
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: () => this.handleAddClick(),
      ),
    );
  }

  void handleAddClick() async {
    String cameraScanResult = await scanner.scan();
    print('Resultado: ' + cameraScanResult);
  }
}
