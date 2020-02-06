import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'Provider/getweather.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: getWeather(),
      child: MaterialApp(
        title: 'WeatherApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int temperature = 0;
  final cityname = TextEditingController();


  void gettemperature(var mapData) {
    setState(() {
      if (mapData == null) {
        temperature = 0;
        return;
      }

      var tem =  mapData['main']['temp'];
 temperature = tem.toInt();


    });
  }


  @override
  void dispose() {
    cityname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<getWeather>(context);
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text('getTemperature'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: TextField(
               controller: cityname,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: 'Enter City Name',

                    hintStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  )),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            color: Colors.blueGrey,
            onPressed: () async {
              if (!cityname.text.isEmpty) {
                var getMapData = await weather.getweather(cityname.text);
                gettemperature(getMapData);
              } else {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('please enter ciny name!'),
                          content: Text('please enter ciny name!'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('OK'),
                              onPressed: () {
                                setState(() {
                                  temperature = 0;
                                });

                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        ));
              }
            },
            child: Text(
              'Get Weather',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${temperature}',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          )
        ],
      ),
    );
  }
}
