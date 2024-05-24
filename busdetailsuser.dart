import 'package:flutter/material.dart';
import 'package:location_track/contactdetails.dart';
import 'package:location_track/feesreceiptuploaduser.dart';

import 'MyHomePage.dart';

class BusDetailsPage extends StatelessWidget {
  final String userEmail; // Add userEmail as a parameter
  const BusDetailsPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Details'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(userEmail: userEmail),
                  ),
                );
              }),
              child: const Card(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.5),
                  child: ListTile(
                    leading:
                        Icon(Icons.library_books_rounded, color: Colors.black),
                    title: Text(
                      'Bus Fees Structure',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0),
                    ),
                  )),
            ),
            TextButton(
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FeesReceiptUpload(userEmail: userEmail)),
                );
              }),
              child: const Card(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.5),
                  child: ListTile(
                    leading:
                        Icon(Icons.receipt_long_rounded, color: Colors.black),
                    title: Text(
                      'Fees Receipt',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0),
                    ),
                  )),
            ),
            TextButton(
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserScreen()),
                );
              }),
              child: const Card(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.5),
                  child: ListTile(
                    leading:
                        Icon(Icons.contact_phone_rounded, color: Colors.black),
                    title: Text(
                      'Contact Details',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
