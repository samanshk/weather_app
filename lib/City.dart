import 'package:flutter/material.dart';
import 'package:weather/Home.dart';
import 'package:geolocator/geolocator.dart';

class City extends StatefulWidget {
  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<City> {
  String city = 'Select your city';
  // Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
  Position position;
  // GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();/

  
  locate() async {
    position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    print(await Geolocator().checkGeolocationPermissionStatus());
    print(position.latitude);
    if (position.latitude != null && position.longitude != null) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Home(
          'http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=895743cb16e606c4254c6978388f3aa8',
          'http://api.openweathermap.org/data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&appid=895743cb16e606c4254c6978388f3aa8'
        )
      ));
    }
  }
  
  findWeather() {
    if (city != 'Select your city') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=895743cb16e606c4254c6978388f3aa8', 'http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=895743cb16e606c4254c6978388f3aa8')));
    }       
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://cruisewhitsundays.imgix.net/2019/04/CWS-Whitehaven-Beach-Drone-shot-person-standing-in-water-landscape_1920.jpg?fit=crop&w=500&h=595&dpr=2.625', 
                // height: double.infinity, 
                // width: double.infinity
              ),
                fit: BoxFit.cover
              )
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DropdownButton<String>(
                        // focusColor: Colors.white,
                        value: city,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                          color: Colors.white
                        ),
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.deepPurpleAccent,
                        // ),
                        onChanged: (String newValue) {
                          setState(() {
                            city = newValue;
                          });
                        },
                        items: <String>['Select your city', 'Jaipur', 'Delhi', 'London', 'Chennai', 'Kolkata', 'Kota', 'Guwahati', 'Amritsar']
                          .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(color: Colors.black, fontSize: 25),),
                            );
                          })
                          .toList(),
                      ),
                      MaterialButton(
                        onPressed: () {findWeather();},
                        color: Colors.green[900],
                        child: Text('Check', style: TextStyle(color: Colors.white, fontSize: 25),),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10),),
                MaterialButton(
                  onPressed: () {locate();},
                  padding: EdgeInsets.all(10),
                  color: Colors.green[900],
                  child: Text('Choose current location', style: TextStyle(color: Colors.white, fontSize: 25),),
                )
              ],
            ),
          ),
          
        ],
      )
      
      
    );
  }
}