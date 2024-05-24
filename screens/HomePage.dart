import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location_track/about_us.dart';
import 'package:location_track/busdeatilsadmin.dart';
import 'package:location_track/locations/admin_bus.dart';
import 'package:location_track/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../EditProfileAdmin.dart';

class HomePage extends StatefulWidget {
  final String userEmail; // Add userEmail as a parameter
  const HomePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return LoginRequired(
      userEmail: widget.userEmail,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'NKOCET',
            style:
                TextStyle(color: Colors.white), // Set the text color to black
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
                launch(
                    'https://www.instagram.com/nkocet?igsh=eHdoZWc5MXYyZ280');
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
                    image: AssetImage(
                      'images/backImg4.jpeg',
                    ),
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
                                  builder: (context) => admin_bus()),
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
                            //   MaterialPageRoute(
                            //       builder: (context) => BroadCast()),
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
                        builder: (context) => const BusDetailsPage()),
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

                /// The above Dart code is handling an onTap event, which triggers the sign-out process using the `_authService.signOut()` method. After signing out, it navigates to the `LoginScreen` by replacing the current route using `Navigator.pushReplacement`.
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
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
                            EditProfileAdmin(userEmail: widget.userEmail)),
                  );
                },
              ),
            ],
          ),
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
    // Delay the initialization of Timer by 1 second to ensure PageView is built
    Future.delayed(const Duration(seconds: 1), () {
      Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        if (_pageController.page! < 2) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
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
  String username = '';

  @override
  void initState() {
    super.initState();
    _userStream = FirebaseFirestore.instance
        .collection('AdminLogin')
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
            const Text(
              "Admin",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              username,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginRequired extends StatelessWidget {
  final String userEmail;
  final Widget child;

  const LoginRequired({Key? key, required this.userEmail, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userEmail.isEmpty) {
      return LoginScreen(
        onLogin: (email) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => child),
          );
        },
      );
    }
    return child;
  }
}

enum DrawerSections {
  firstpage,
}
