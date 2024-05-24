import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location_track/about_us.dart';
import 'package:location_track/busdetailsuser.dart';
import 'package:location_track/locations/allbusses.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../EditProfilePage.dart';
import 'login_screen.dart';

class HomePageUser extends StatefulWidget {
  final String userEmail;
  const HomePageUser({Key? key, required this.userEmail}) : super(key: key);

  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  var currentPage = DrawerSections.firstpage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NKOCET',
          style: TextStyle(color: Colors.white), // Set the text color to black
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              launch('https://www.orchidengg.ac.in/');
            },
            icon: const Icon(FontAwesomeIcons.google),
          ),
          IconButton(
            onPressed: () {
              launch('https://www.facebook.com/NKORCHIDENGG?mibextid=ZbWKwL');
            },
            icon: const Icon(FontAwesomeIcons.facebook),
          ),
          IconButton(
            onPressed: () {
              launch('https://www.instagram.com/nkocet?igsh=eHdoZWc5MXYyZ280');
            },
            icon: const Icon(FontAwesomeIcons.instagram),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height *
                0.35, // 35% of the screen height
            child: Image.asset(
              'images/college_pic_HomePage.jpeg', // Replace 'your_image_asset_path.jpg' with your image asset path
              fit: BoxFit.cover,
            ),
          ),
          const Expanded(
            flex: 35,
            child: SlidingCardList(),
          ),
          Expanded(
            flex: 30,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/backImg4.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => allbusses()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.lightBlue, // Change button color here
                          elevation: 3, // Add elevation
                          shadowColor: Colors.blue, // Customize shadow color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add border radius for a rounded appearance
                          ),
                        ),
                        child: const Text('Track Bus'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => BroadCast()),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.lightBlue, // Change button color here
                          elevation: 3, // Add elevation
                          shadowColor: Colors.blue, // Customize shadow color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add border radius for a rounded appearance
                          ),
                        ),
                        child: const Text('Broadcast'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Text(
                      'NK Orchid College Of Engineering Bus System',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Colors.blue, // Add blue color here
              child: MyHeaderDrawer(
                userEmail: widget.userEmail,
              ),
            ), // Pass userEmail to MyHeaderDrawer
            ListTile(
              leading:
                  const Icon(Icons.location_on_outlined), // Add leading icon
              title: const Text(
                'Bus Track',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => allbusses()),
                );
                // Add your navigation logic for Bus Track
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_bus),
              title: const Text(
                'Bus Details',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BusDetailsPage(userEmail: widget.userEmail)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Add your navigation logic for Notifications
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text(
                'About Us',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('email');
                await prefs.remove('role');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(onLogin: (email) {})),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditProfilePage(userEmail: widget.userEmail)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SlidingCardList extends StatefulWidget {
  const SlidingCardList({Key? key}) : super(key: key);

  @override
  _SlidingCardListState createState() => _SlidingCardListState();
}

class _SlidingCardListState extends State<SlidingCardList> {
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );

  @override
  void initState() {
    super.initState();
    // Delay the initialization of Timer by a short duration to ensure PageView is built
    Future.delayed(Duration(milliseconds: 100), () {
      Timer.periodic(Duration(seconds: 3), (Timer timer) {
        if (_pageController.page! < 2) {
          _pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.jumpToPage(0);
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: const [
        SlidingCard(
          title: 'Card 1',
          imagePath: 'images/card1.jpeg',
        ),
        SlidingCard(
          title: 'Card 2',
          imagePath: 'images/card2.jpeg',
        ),
        SlidingCard(
          title: 'Card 3',
          imagePath: 'images/card3.png',
        ),
      ],
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const SlidingCard({Key? key, required this.title, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imagePath,
              height: 250,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class MyHeaderDrawer extends StatefulWidget {
  final String userEmail; // Add userEmail as a parameter
  const MyHeaderDrawer({Key? key, required this.userEmail}) : super(key: key);

  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  late Stream<DocumentSnapshot> _userStream;
  String firstName = '';
  String secondName = '';
  String username = '';

  @override
  void initState() {
    super.initState();
    _userStream = FirebaseFirestore.instance
        .collection('UserLogin')
        .where('Username',
            isEqualTo: widget
                .userEmail) // Assuming widget.userEmail holds the email of the current user
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        throw Exception('User document not found');
      }
    });

    // Fetch additional data from 'UserLogin' collection
    fetchAdditionalData();
  }

  void fetchAdditionalData() {
    _userStream.listen((userDoc) {
      setState(() {
        firstName = userDoc.get('firstName') ?? '';
        secondName = userDoc.get('secondName') ?? '';
        username = userDoc.get('Username') ?? '';
      });
    }, onError: (error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('images/profile.jpg'),
                ),
              ),
            ),
            Center(
              child: Text(
                '$firstName $secondName',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                username,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum DrawerSections {
  firstpage,
}
