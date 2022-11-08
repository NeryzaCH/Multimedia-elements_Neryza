import 'package:deneb_v2/screens/add_planet_screen.dart';
import 'package:flutter/material.dart';
import 'package:deneb_v2/helpers/planets_helper.dart';
import 'package:deneb_v2/models/planet_model.dart';
import 'package:deneb_v2/PlanetCards/EarthCard.dart';
import 'package:deneb_v2/PlanetCards/MarsCard.dart';
import 'package:deneb_v2/PlanetCards/MercuryCard.dart';
import 'package:deneb_v2/PlanetCards/VenusCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("DimaSoft"),
          backgroundColor: Color.fromARGB(255, 94, 93, 93),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                final route =
                    MaterialPageRoute(builder: (context) => Add_planet());
                Navigator.push(context, route);
              },
            ),
          ],
          elevation: 0),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                child: Text(
                  'System:',
                  style: TextStyle(
                    color: Color.fromARGB(255, 122, 119, 119),
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              height: 485,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MercuryCard(),
                  VenusCard(),
                  EarthCard(),
                  MarsCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
