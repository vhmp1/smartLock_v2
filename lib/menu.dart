import 'package:flutter/material.dart';

import 'status.dart';
import 'config.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.vpn_key),
        title: Text('smartLock'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Status
              Card(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width-20.0,
                  child: InkWell(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.trending_up, size: 100.0),
                        Text('Status'),
                      ] 
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => StatusPage())),
                  ),
                ) 
              ),
              // Config
              Card(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width-20.0,
                  child: InkWell(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.settings, size: 100.0),
                        Text('Configurações'),
                      ] 
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfigPage())),
                  ),
                ), 
              ),
              // History
              Card(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width-20.0,
                  child: InkWell(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.save_alt, size: 100.0),
                        Text('Histótico'),
                      ] 
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => StatusPage())),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}