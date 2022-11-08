import 'package:flutter/material.dart';
import 'package:deneb_v2/helpers/systems_helper.dart';
import 'package:deneb_v2/models/system_model.dart';
import 'package:deneb_v2/screens/home.dart';

class Add_system extends StatefulWidget {
  Add_system({Key? key}) : super(key: key);

  @override
  State<Add_system> createState() => _AddsystemState();
}

class _AddsystemState extends State<Add_system> {
  final textControllerName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int ratingvalue = 5;

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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: Text(
          "Add a new system",
          style: TextStyle(color: Colors.black),
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
            SizedBox(
              height: 20,
            ),
            FloatingActionButton.extended(
                label: const Text("Save the new planet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
                backgroundColor: Color.fromARGB(255, 143, 137, 127),
                icon: const Icon(
                  Icons.save_alt_rounded,
                  size: 25.0,
                  color: Colors.white,
                ),
                onPressed: () async {
                  PlanetHelper.instance
                      .addSystem(System(name: textControllerName.text));
                  setState(() {
                    textControllerName.clear();
                  });
                }),
            SizedBox(height: 5),
            FutureBuilder<List<System>>(
                future: PlanetHelper.instance.getSystems(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<System>> snapshot) {
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
