import 'package:flutter/material.dart';
import 'package:deneb_v2/helpers/planets_helper.dart';
import 'package:deneb_v2/models/planet_model.dart';
import 'package:deneb_v2/screens/home.dart';
import 'package:deneb_v2/screens/home_screen.dart';

class Add_planet extends StatefulWidget {
  Add_planet({Key? key}) : super(key: key);

  @override
  State<Add_planet> createState() => _AddpplanetState();
}

class _AddpplanetState extends State<Add_planet> {
  final textControllerName = TextEditingController();
  final textControllerImage = TextEditingController();
  final textControllerDescription = TextEditingController();
  final textControllerType = TextEditingController();
  final textControllerNature = TextEditingController();
  final textControllerSize = TextEditingController();
  final textControllerDistance = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 75,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          iconSize: 30,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen2()));
          },
        ),
        title: Text(
          "Add a new Planet",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            TextFormField(
                controller: textControllerName,
                decoration: const InputDecoration(
                    icon: Icon(Icons.text_format_outlined), labelText: "Name")),
            TextFormField(
                controller: textControllerImage,
                decoration: const InputDecoration(
                    icon: Icon(Icons.image_outlined),
                    labelText: "You can insert an image here")),
            TextFormField(
                controller: textControllerDescription,
                decoration: const InputDecoration(
                    icon: Icon(Icons.description_outlined),
                    labelText: "Description")),
            TextFormField(
                controller: textControllerType,
                decoration: const InputDecoration(
                    icon: Icon(Icons.text_format_outlined), labelText: "Type")),
            TextFormField(
                controller: textControllerNature,
                decoration: const InputDecoration(
                    icon: Icon(Icons.nature_outlined), labelText: "Nature")),
            TextFormField(
                controller: textControllerSize,
                decoration: const InputDecoration(
                    icon: Icon(Icons.numbers_outlined), labelText: "Size")),
            TextFormField(
                controller: textControllerDistance,
                decoration: const InputDecoration(
                    icon: Icon(Icons.settings_ethernet_outlined),
                    labelText: "Distance from the earth")),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton.extended(
                label: const Text("Save the new planet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
                backgroundColor: Color.fromARGB(255, 141, 127, 143),
                icon: const Icon(
                  Icons.save_alt_rounded,
                  size: 25.0,
                  color: Colors.white,
                ),
                onPressed: () async {
                  PlanetHelper.instance.addPlanet(Planet(
                      name: textControllerName.text,
                      image: textControllerImage.text,
                      description: textControllerDescription.text,
                      type: textControllerType.text,
                      nature: textControllerNature.text,
                      size: textControllerSize.text,
                      distance: textControllerDistance.text));
                  setState(() {
                    textControllerName.clear();
                    textControllerImage.clear();
                    textControllerDescription.clear();
                    textControllerType.clear();
                    textControllerNature.clear();
                    textControllerSize.clear();
                    textControllerDistance.clear();
                  });
                }),
            SizedBox(height: 5),
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
                            child: Container(child: const Text("No planets")))
                        : ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: snapshot.data!.map(
                              (planet) {
                                return Center(
                                  child: Card(
                                      child: ListTile(
                                    title: Text(
                                        'Id: ${planet.id}, Name: ${planet.name}'),
                                  )),
                                );
                              },
                            ).toList());
                  }
                })
          ],
        ),
      ),
    );
  }
}
