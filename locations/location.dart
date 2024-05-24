import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location_track/locations/mymap.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class location1 extends StatefulWidget {
  const location1({super.key, required this.n});
  final String? s1 = 'location';
  final String? n;
  @override
  State<location1> createState() => _location(n);
}

class _location extends State<location1> {
  final String? l;
  _location(this.l);
  //final String s1;
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initState() {
    //  PolygoneScreen();
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Where Is My Bus!"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('\nLOCATION TRACKING',
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold)),
          const CircleAvatar(
            radius: 50.0,
            // Icon(Icons.add_location_alt_outlined, color: Colors.teal),
            backgroundImage: NetworkImage(
                "https://static.vecteezy.com/system/resources/previews/000/423/620/original/vector-school-bus-icon.jpg"),
          ),
          TextButton(
            onPressed: () {
              //condition if stop no ho tho
              Timer.periodic(Duration(seconds: 1), (_) => _getLocation());
              //_listenLocation();
            },
            child: const Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.5),
                child: ListTile(
                  leading: Icon(Icons.location_on, color: Colors.deepPurple),
                  title: Text(
                    'Add my Location',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 20.0),
                  ),
                )),
            //Text('add my location'),
          ),
          TextButton(
            onPressed: () {
              print(l);

              _stopListening();
            },

            child: const Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.5),
              child: ListTile(
                leading: Icon(Icons.close, color: Colors.deepPurple),
                title: Text(
                  'Stop Live location',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0),
                ),
              ),
            ),
            //Text('stop live location')
          ),
          Expanded(
              child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('location$l').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        snapshot.data!.docs[index]['name'].toString(),
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 20.0),
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            snapshot.data!.docs[index]['latitude'].toString(),
                            style: const TextStyle(
                                color: Colors.deepPurple,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 20.0),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            snapshot.data!.docs[index]['longitude'].toString(),
                            style: const TextStyle(
                                color: Colors.deepPurple,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 20.0),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.directions),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MyMap(snapshot.data!.docs[index].id, l)));
                        },
                      ),
                    );
                  });
            },
          )),
        ],
      ),
    );
  }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance
          .collection('location$l')
          .doc('user1')
          .set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': 'User_phone'
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
    _listenLocation();
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance
          .collection('location$l')
          .doc('user1')
          .set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'USER_PHONE'
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
