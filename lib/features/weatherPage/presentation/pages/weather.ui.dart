import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather/features/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/presentation/bloc/weather_event.dart';
import 'package:weather/features/presentation/bloc/weather_state.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
   final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.076090, 72.877426),
    zoom: 14.4746,
  );


  // on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {

    final _height = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

     // created method for getting user current location

 
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: _height * 0.2,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  BlocBuilder<WeatherBloc,WeatherState>(
                  builder: (context,state) {
                    
                    if (state is WeatherLoaded) {
                      return Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      
                        children: [
                        Column(
                          children: [
                                                          Text('Precipitation',style: TextStyle(fontSize: 20),),
                              SizedBox(height: 14,),

                            Text('${state.result.precipitation}',style: TextStyle(fontSize: 17),),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Temperature',style: TextStyle(fontSize: 20),),
                                                          SizedBox(height: 14,),

                            Text('${state.result.minTemperature} - ${state.result.maxTemperature}',style: TextStyle(fontSize: 17),),
                          ],
                        ),
                      ]);
                    }if (state is WeatherLoadFailue) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      
                          children: [
                          Column(
                            children: [
                              Text('Precipitation',style: TextStyle(fontSize: 20),),
                              SizedBox(height: 14,),
                              Text('0',style: TextStyle(fontSize: 17),),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Temperature',style: TextStyle(fontSize: 20),),
                                                            SizedBox(height: 14,),

                              Text('0 - 0',style: TextStyle(fontSize: 17),),
                            ],
                          ),
                        ]);
                  }),
                ],
              ),
               ),
              SizedBox(
              height: _height * 0.75,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                myLocationEnabled: true,
            markers: Set<Marker>.of(_markers),
      compassEnabled: true,
                ),
            ),
          ],
        ),
      ),
         floatingActionButton: FloatingActionButton(
        onPressed: () async{
          getUserCurrentLocation().then((value) async {
            print(value.latitude.toString() +" "+value.longitude.toString());
 
            // marker added for current users location
            _markers.add(
                Marker(
                  markerId: MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: InfoWindow(
                    title: 'My Current Location',
                  ),
                )
            );
 
            // specified current users location
            CameraPosition cameraPosition = new CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14,
            );
 
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {
            });

            context.read<WeatherBloc>().add(OnPosition(value.latitude.toString(), value.longitude.toString(), '2023-08-28'));

          });



        },
        child: Icon(Icons.local_activity),
      ),
    
    
    
    ); }
}