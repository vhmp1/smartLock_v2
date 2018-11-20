import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services.dart';
import 'services.dart' as bluetooth;

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  bool _isManual = false, _isDist = false, _isTime = false, _isPanic = false;
  double _dist = 100.0;
  TimeOfDay _timeOpen = TimeOfDay.now(), _timeClose = TimeOfDay.now();

  void initState() {
    super.initState();
    _initValues();
  }

  void _initValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    _isManual = (prefs.getBool('isManual') ?? false);

    _isDist = (prefs.getBool('isDist') ?? false);
    _dist = (prefs.getDouble('dist') ?? 100.0);

    _isTime = (prefs.getBool('isTime') ?? false);
    _timeOpen = (prefs.getString('time') ?? TimeOfDay.now());
    _timeClose = (prefs.getString('time') ?? TimeOfDay.now());

    _isPanic = (prefs.getBool('panic') ?? false);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: ListView(
        children: <Widget>[
          // Manual
          ListTile(
            title: Text('Tranca manual'),
            trailing: Switch(
              onChanged: _setManual,
              value: _isManual,
            ),
          ),
          Divider(color: Colors.grey,),
          // Distância
          ListTile(
            title: Text('Tranca por distância'),
            trailing: Switch(
              onChanged: _setDist,
              value: _isDist,
            ),
          ),
          Row(
            children: <Widget>[
              Slider(
                value: 200.0,
                onChanged: (double value) => setState(() {_dist = value;}),
                divisions: 100,
                max: 500.0,
                min: 100.0,
              ),
              Text('$_dist'),
            ],
          ),
          Divider(color: Colors.grey,),
          // Tempo
          ListTile(
            title: Text('Tranca programada'),
            trailing: Switch(
              onChanged: _setTime,
              value: _isTime,
            ),
          ),
          ListTile(
            title: Text('Abertura'),
            trailing: FlatButton(
              child: Text('$_timeOpen'),
              onPressed: () => setState(() async { _timeOpen = await showTimePicker(initialTime: TimeOfDay.now(), context: context); }),
            ),
          ),
          ListTile(
            title: Text('Fechamento'),
            trailing: FlatButton(
              child: Text('$_timeClose'),
              onPressed: () => setState(() async { _timeClose = await showTimePicker(initialTime: TimeOfDay.now(), context: context); }),
            ),
          ),
          Divider(color: Colors.grey,),
          // Panic mode
          ListTile(
            title: Text('Modo bluetooth'),
            trailing: Switch(
              onChanged: _panicMode,
              value: _isPanic,
              activeColor: Colors.red,
            ),
          ),
          ListTile(
            title: Text('Configurar bluetooth ${bluetooth.device != null ? 'conectado' : 'desconectado'}'),
            trailing: IconButton(
              icon: Icon(Icons.bluetooth),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlutterBlueApp())),
            ),
          )
        ],
      ),
    );
  }

  _setManual(value) async{
    String cmd = '1:' + (value?'1':'0') + '#';

    if(_isPanic && bluetooth.device == null)
      return;

    bluetooth.writeCharacteristic(cmd.codeUnits);

    setState(() { 
      _isManual = value; 
    });
  }

  _setDist(value) async{
    String cmd = '2:' + (value?'1':'0') + ';' + _dist.toString() + '#';

    if(_isTime || (_isPanic && bluetooth.device == null)) return;

    bluetooth.writeCharacteristic(cmd.codeUnits);
    setState(() { 
      _isDist = value; 
    });
  }

  _setTime(value) async{
    String cmd = '3:' + (value?'1':'0') + ';' + _timeOpen.hour.toString() + ';' + _timeOpen.minute.toString() + '#';
    
    if(_isDist || (_isPanic && bluetooth.device == null)) return;

    bluetooth.writeCharacteristic(cmd.codeUnits);

    setState(() { 
      _isTime = value; 
    });
  }
  
  _panicMode(value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('panic', value);

    setState(() {
      _isPanic = value;
    });
  }

  
}