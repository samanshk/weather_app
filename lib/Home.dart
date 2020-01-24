import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class Home extends StatefulWidget {
  String url, forecastUrl;
  Home(this.url, this.forecastUrl);
  @override
  _HomeState createState() => _HomeState(url, forecastUrl);
}

class _HomeState extends State<Home> {
  String url, forecastUrl;
  _HomeState(this.url, this.forecastUrl);
  // var url = 'http://api.openweathermap.org/data/2.5/weather?q=Jaipur&appid=895743cb16e606c4254c6978388f3aa8';
  var convertedData, futureData;
  var sunrise, sunset;

  Future<String> fetchData() async {
    var response = await http.get(Uri.encodeFull(url));
    var futureResponse = await http.get(Uri.encodeFull(forecastUrl));
    print(response.body);
    print(futureResponse.body);
    setState(() {
      convertedData = json.decode(response.body);
      sunrise = DateTime.fromMillisecondsSinceEpoch(convertedData['sys']['sunrise'] * 1000);
      sunset = DateTime.fromMillisecondsSinceEpoch(convertedData['sys']['sunset'] * 1000);

      futureData = json.decode(futureResponse.body);
    });
  }

  Widget forecast(i) {
    return Column(
      children: <Widget>[
        Card(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text((futureData['list'][i]['dt_txt']).substring(0, 10) + '\n' + (futureData['list'][i]['dt_txt']).substring(10, 19), style: TextStyle(fontSize: 20, color: Colors.white) ),
              Text('⛅', style: TextStyle(fontSize: 20)),
              Text((futureData['list'][i]['main']['temp']-273).toStringAsFixed(2) + '°C', style: TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }

  // Widget forecastBuilder() {
  //   return Column(
  //     children: <Widget>[
  //       for (var i = 0; i < futureData['list'].length-1; i++) {
  //         forecast(i)
  //       }
  //     ],
  //   );
  // } 

  @override
  void initState() {
    fetchData();
  
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    if (convertedData == null) {}
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        backgroundColor: Colors.green[900],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://www.brecorder.com/wp-content/uploads/2019/10/The-Weather.jpg', 
                
              ),
                fit: BoxFit.cover
              )
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(convertedData['name'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white)),
                  Image.asset('assets/weather.png'),
                  Card(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    child: Column(
                      children: <Widget>[
                        Text('${(convertedData['main']['temp'] - 273).toStringAsFixed(2)}°C', style: TextStyle(fontSize: 50, color: Colors.white)),
                        Padding(padding: EdgeInsets.all(10),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('🌐', style: TextStyle(fontSize: 20, color: Colors.white),),
                                Text('${convertedData['coord']['lat']}/${convertedData['coord']['lon']}', style: TextStyle(fontSize: 25, color: Colors.white))
                              ],
                            ),
                            // Text('${(convertedData['main']['temp'] - 273).toStringAsFixed(2)}°C', style: TextStyle(fontSize: 50, color: Colors.white)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('💧', style: TextStyle(fontSize: 20, color: Colors.white),),
                                Text('${convertedData['main']['humidity']}%', style: TextStyle(fontSize: 25, color: Colors.white))
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('🌀', style: TextStyle(fontSize: 20, color: Colors.white),),
                                Text('${convertedData['wind']['speed']}', style: TextStyle(fontSize: 25, color: Colors.white))
                              ],
                            ),
                          ]
                          
                        ),
                      ],
                    ) 
                    
                  ),
                  Card(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Icon(Icons.wb_sunny, size: 35, color: Colors.white,),
                            Text('🔆', style: TextStyle(fontSize: 45, color: Colors.white),),
                            Text(sunrise.toString().substring(10, 19), style: TextStyle(fontSize: 15, color: Colors.white))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Icon(Icons.n size: 35, color: Colors.white,),
                            Text('🌙', style: TextStyle(fontSize: 45, color: Colors.white),),
                            Text(sunset.toString().substring(10, 19), style: TextStyle(fontSize: 15, color: Colors.white))
                          ],
                        ),
                      ]                    
                    ),
                  ),
                  forecast(0),
                  forecast(1),
                  forecast(2),
                  forecast(3),
                  forecast(4),
                  forecast(5),
                  forecast(6),
                  forecast(7),
                  forecast(8),
                  forecast(9),
                  forecast(10),
                  forecast(11),

                ],
              ),
            ),
          )
        ],
      )
      
    );
  }
}