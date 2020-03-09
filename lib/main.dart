import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
//import 'package:intent/intent.dart' as android_intent;
//import 'package:intent/action.dart' as android_action;
import 'dart:async';

void main(){
  runApp(MaterialApp(
    home: GeoListenPage()
  ));
}

class GeoListenPage extends StatefulWidget {
  @override
  _GeoListenPageState createState() => _GeoListenPageState();
}

class _GeoListenPageState extends State<GeoListenPage> {

  Geolocator geolocator = Geolocator();

  Position userLocation;
  
  var tel = '';
  var citys = [
    {
      'cidade': 'Varze Alegre',
      'location': [-6.7945416, -39.2923196],
      'tel': '88 3541-1308'
    },
    {
      'cidade': 'Cedro',
      'location': [-6.6055679, -39.0587997],
      'tel': '88 3564-0194' 
    },
    {
      'cidade': 'Iguatu',
      'location': [-6.3737751, -39.3072796],
      'tel': '88 3581-0307'
    },
    {
      'cidade': 'Icó',
      'location': [-6.4081073, -38.8578701],
      'tel': '88 3541-1308'
      
    },
    {
      'cidade': 'Lavras da Mangabeira',
      'location': [-6.7465579, -38.9649305],
      'tel': '88 3541-1308'
      
    }
  ];

  //Calcular 
  void _calcular() async {
    final double startLatitude = userLocation.latitude; 
    final double startLongitude = userLocation.longitude;

    double compLatitude = 0.0; 
    double compLongitude = 0.0; 

    double distance = 0.0;
    var contact = '';
    var cidade = '';
    double distance_k = 99999.0;
    var coord =[];

    //Encontrar a menor distancia
    for ( var city in citys){
      coord = (city['location']);
 
      compLatitude = coord[0];
      compLongitude = coord[1];

      distance = await Geolocator().distanceBetween(
        startLatitude, startLongitude, compLatitude, compLongitude);

      print('Distancia: $distance');
      print(city['cidade']);

      if( distance < distance_k ){
        distance_k = distance;
        contact = (city['tel']);
        cidade = (city['cidade']);
      }
    }
    print('Menor Distancia: $distance_k');
    print('Cidade: $cidade');
    print('Numero: $contact');

    //Função de fazer ligação.
    UrlLauncher.launch('tel: $contact');
  }
 
 /*.
  void _launchURL() async{
      android_intent.Intent()
    ..setAction(android_action.Action.ACTION_DIAL)
    ..setData(Uri(scheme: "tel", path: "$tel"))
    ..startActivity().catchError((e) => print(e));
  }
  */
  @override
  void initState() {
    super.initState();
    _getLocation().then((position) {
      userLocation = position;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("SOS CIDADÃO "),
        centerTitle: true,
        backgroundColor: Colors.blue,
       ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[   
            Icon(
                Icons.location_city,
                color: Colors.black,
                size: 120.0,
              ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                 shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(120.0),
                  side: BorderSide(color: Colors.red)),
                onPressed: () {
                  _getLocation().then((value) {
                    setState(() {
                      userLocation = value;
                    });
                  });
                  _calcular();
                  //_launchURL();
                },
                color: Colors.red,
                child: Text(
                  "SOS",
                  style: TextStyle(color: Colors.white,fontSize: 140.0,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition();
    } catch (e) {
      currentLocation = null;
    }
    
    return currentLocation;
  }
}
