import 'package:flutter/material.dart';
import 'package:location_track/contactdetails.dart';
import 'package:location_track/fees_receipts_admin.dart';

class BusDetailsPage extends StatelessWidget {
  const BusDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Details'),
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
                      builder: (context) => const FeesReceiptAdmin()),
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
                  MaterialPageRoute(builder: (context) => const AdminScreen()),
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
