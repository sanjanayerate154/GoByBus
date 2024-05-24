import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyMap extends StatefulWidget {
  final String user_id;
  final String? lo;
  MyMap(this.user_id, this.lo);

  @override
  _MyMapState createState() => _MyMapState(lo);
}

class _MyMapState extends State<MyMap> {
  final String? l;

  _MyMapState(this.l);

  final Set<Marker> _markers = {};
  bool _added = false;

  List<LatLng> points1 = [
    LatLng(17.658518, 75.936379), //ASHOK CHOWK
    LatLng(17.631852, 75.908861), //KANNA
    LatLng(17.635648, 75.897974),
    LatLng(17.626141, 75.898396),
    LatLng(17.633000, 75.895261),
    LatLng(17.638826, 75.896599),
    LatLng(17.688525, 75.902253),
    LatLng(17.720287, 75.918749), //clg
    //KANNA
    //KANNA
  ];

  List<LatLng> points2 = [
    LatLng(17.637074, 75.898063), //'nehru nagar \n   - 9.05 AM',

    LatLng(17.643654, 75.899018), //'I.T.I \n   - 9.10 AM',

    LatLng(17.639406, 75.924106), // 'rasul hotel \n   - 9.15 AM',

    LatLng(17.652938, 75.904757), //  'patrakar bhavan \n   - 9.25 AM',

    LatLng(17.684784, 75.913642), // 'Doodh Dairy \n   - 9.30 AM',

    LatLng(17.720287, 75.918749), // 'Orchid college \n   - 9.45 AM'
  ];
  List<LatLng> points3 = [
    ///golllll
    ///
    LatLng(17.635635, 75.913392), //'D-mart ( jule solapur) \n   - 9.00 AM',
    LatLng(17.636641, 75.910863), //'Govindshree \n   - 9.05 AM',//c
    LatLng(17.639995, 75.901624), //'bharati vidyapeeth \n   - 9.10 AM',//c
    LatLng(17.649146, 75.902125), //'kambar talav \n   - 9.20 AM',
    LatLng(17.720287, 75.918749), //'Orchid college \n   - 9.45 AM'  //c
  ];
  List<LatLng> points = [];

  List<LatLng> points4 = [
    LatLng(17.658249, 75.906752), //'Saat Rasta \n   - 9.10 AM',
    LatLng(17.657443, 75.902867), //'Modi \n   - 9.15 AM',
    LatLng(17.659049, 75.898191), //'DRM office \n   - 9.15 AM',
    LatLng(17.664384, 75.894141), //'railway station \n   - 9.30 AM',
    LatLng(17.685289, 75.900769), //'samrat chowk  \n   - 9.35 AM',   //c
    LatLng(
        17.671312, 75.908772), //'Mantri Chandak(Rupa bhavani) \n   - 9.40 AM',
    LatLng(17.720287, 75.918749), //'Orchid college \n   - 9.45 AM'
  ];

// Define your custom marker icon
  BitmapDescriptor? busIcon;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  final Map<PolylineId, Polyline> _polylines = {};
  @override
  void initState() {
    checkpoint();
    loadBusIcon();

    super.initState();
    _addPolyline();
    // Load the custom marker icon
  }

  void checkpoint() {
    setState(() {
      switch (l) {
        case "1":
          points = points1;
          break;
        case "2":
          points = points2;
          break;
        case "3":
          points = points3;
          break;
        case "4":
          points = points4;
          break;
        default:
          points = [];
      }
    });
  }

  void _addPolyline() {
    List<LatLng> polylineCoordinates = points;

    PolylineId id = PolylineId("poly");

    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );

    setState(() {
      _polylines[id] = polyline;
    });
  }

  // Load the custom marker icon
  void loadBusIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'images/bus.png')
        .then(
      (icon) {
        sourceIcon = icon;
      },
    );
    // Change the path to 'images/busicon.jpeg'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('location$l').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!_added) {
            _addMarkers(snapshot);
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return GoogleMap(
            mapType: MapType.normal,
            markers: _markers,
            polylines: Set<Polyline>.of(_polylines.values),
            initialCameraPosition: CameraPosition(
              target: LatLng(
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.user_id)['latitude'],
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.user_id)['longitude'],
              ),
              zoom: 15.47,
            ),
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                _added = true;
              });
            },
          );
        },
      ),
    );
  }

  void _addMarkers(AsyncSnapshot<QuerySnapshot> snapshot) {
    // Add marker for the user's location
    _markers.add(Marker(
      markerId: MarkerId('user_location'), //live location  bus.dart
      position: LatLng(
        snapshot.data!.docs
            .singleWhere((element) => element.id == widget.user_id)['latitude'],
        snapshot.data!.docs.singleWhere(
            (element) => element.id == widget.user_id)['longitude'],
      ),
      icon: sourceIcon,
      /* icon: busIcon ??
            BitmapDescriptor
                .defaultMarker, // Use custom icon if available, otherwise use default marker,
                */
    ));
    _markers.add(Marker(
      markerId: MarkerId('user_location'),
      position: LatLng(17.720287, 75.918749), // this is a destination
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
        // InfoWindow for label
        title: 'Destination',
        /* icon: busIcon ??
            BitmapDescriptor
                .defaultMarker, // Use custom icon if available, otherwise use default marker,
                */
      ),
    ));

    // Add markers for other points
    for (int i = 0; i < points.length - 1; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: points[i],
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }
  }
}
