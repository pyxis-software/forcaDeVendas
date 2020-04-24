import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Teste extends StatefulWidget {
  Teste({Key key}) : super(key: key);

  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  Position position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              CircularProgressIndicator(),
              Text("Carregando...", style: TextStyle(fontSize: 18)),
              if (position != null)
                Text(
                    "Latitude: ${position.latitude} - Longitude: ${position.longitude}"),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Pegar Localização",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                onTap: () {
                  _getPosition();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getPosition() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    var status = await geolocator.checkGeolocationPermissionStatus();
    bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();
    if(isLocationEnabled){
      print("GPS ligado!");
    }else{
      print("GPS desligado");
    }

    if (status == GeolocationStatus.denied) {
      // Take user to permission settings
      print("Sem permissão");
    } 
    else if (status == GeolocationStatus.granted) {
      print("Tudo Permitido");
    }


    // Permission granted and location enabled
  }
}
