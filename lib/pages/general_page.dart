import 'package:flutter/material.dart';
import 'package:flutter_codigo_futures/data/data_future.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralPage extends StatefulWidget {
  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  List<Map<String, dynamic>> people = [];

  DataFuture _dataFuture = DataFuture();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool isLoading = true;
  int numero = 0;

  @override
  initState() {
    super.initState();
    _dataFuture;
    people;
    getDataShared();
    getData();
  }

  getData() {
    _dataFuture.getDataList().then((value) {
      people = value;
      isLoading = false;
      setState(() {});
    });
  }

  saveDataShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name${people.length}", _fullNameController.text);
    prefs.setString("address${people.length}", _addressController.text);
    numero = people.length;
    setState((){});
  }

  getDataShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name${people.length}") ?? "-";
    String address = prefs.getString("address${people.length}") ?? "-";

    prefs.getInt("number${people.length}") ?? 0;
    // people.add(
    //   {
    //     "fullName": name,
    //     "address": address,
    //   },
    // );
  }

  removeDataShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2D2D2D),
      appBar: AppBar(
        title: Text("Integrantes"),
        backgroundColor: Color(0xff2D2D2D),
        actions: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              child: Text(numero.toString()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Gestionar datos",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            child: TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                hintText: "Nombre completo",
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            child: TextField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: "Dirección",
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            height: 50,
            width: double.infinity,
            child: ElevatedButton.icon(
                onPressed: () {
                  Map<String, dynamic> person = {
                    "fullName": _fullNameController.text,
                    "address": _addressController.text,
                  };

                  _dataFuture.addPerson(person);
                  saveDataShared();
                  isLoading = true;
                  setState(() {});
                  getData();
                  getDataShared();
                  _fullNameController.clear();
                  _addressController.clear();
                },
                icon: Icon(Icons.save),
                label: Text(
                  "Guardar",
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: !isLoading
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: people.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(people[index]["fullName"]),
                            subtitle: Text(people[index]["address"]),
                            trailing: IconButton(
                              onPressed: () {
                                removeDataShared();
                              },
                              icon: Icon(Icons.delete),
                            ),
                          );
                        })
                    : const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.2,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
              )),
        ],
      ),
    );
  }
}
