import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main(){
  runApp(MaterialApp(
    home: GetLocationPage()
  ));
}

class GetLocationPage extends StatefulWidget {
  @override
  _GetLocationPageState createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {

  var location = new Location();
  var citys = [
    {
      'cidade': 'Varze Alegre',
      'location': [-6.7945416, -39.2923196],
      'tel': '(88) 3541-1308'
    }
    {
      'cidade': 'Cedro',
      'location': [-6.6055679, -39.0587997],
      'tel': '(88) 3564-0194' 
    }
    {
      'cidade': 'Iguatu',
      'location': [-6.3737751, -39.3072796],
      'tel': '(88) 3581-0307'
    }
    {
      'cidade': 'Icó',
      'location': [-6.4081073, -38.8578701],
      'tel': '(88) 3541-1308'
      
    }
    {
      'cidade': 'Lavras da Mangabeira',
      'location': [-6.7465579, -38.9649305],
      'tel': '(88) 3541-1308'
      
    }
  ];

  Map<String, double> userLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userLocation == null
                ? CircularProgressIndicator()
                : Text("Location:" +
                    userLocation["latitude"].toString() +
                    " " +
                    userLocation["longitude"].toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  _getLocation().then((value) {
                    setState(() {
                      userLocation = value;
                    });
                  });
                },
                color: Colors.blue,
                child: Text("Get Location", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
 Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}
