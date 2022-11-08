import 'package:deneb_v2/screens/add_planet_screen.dart';
import 'package:flutter/material.dart';
import 'package:deneb_v2/helpers/planets_helper.dart';
import 'package:deneb_v2/models/planet_model.dart';
import 'package:deneb_v2/PlanetCards/EarthCard.dart';
import 'package:deneb_v2/PlanetCards/MarsCard.dart';
import 'package:deneb_v2/PlanetCards/MercuryCard.dart';
import 'package:deneb_v2/PlanetCards/VenusCard.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("DimaSoft"),
          backgroundColor: Color.fromARGB(255, 98, 86, 102),
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
            image: AssetImage('assets/back2.jpg'),
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
                  'Solar System',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 32,
                    fontFamily: 'SundayMorning',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              height: 485,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  FutureBuilder<List<Planet>>(
                      future: PlanetHelper.instance.getPlanets(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Planet>> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: const Text("Loading..."),
                            ),
                          );
                        } else {
                          return snapshot.data!.isEmpty
                              ? Center(
                                  child: Container(
                                      child: const Text("No planets")))
                              : ListView(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children: snapshot.data!.map(
                                    (planet) {
                                      return Center(
                                        child: Card(
                                            color: Color.fromARGB(
                                                255, 117, 85, 115),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            margin: EdgeInsets.all(15),
                                            elevation: 10,
                                            child: ListTile(
                                              leading: Image.network(
                                                  '${planet.image}'),
                                              title: Text(
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  '${planet.name}'),
                                              subtitle: Text(
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  '${planet.description} \nSize: ${planet.size} km'),
                                            )),
                                      );
                                    },
                                  ).toList());
                        }
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
