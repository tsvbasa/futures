import 'package:flutter/material.dart';
import 'package:flutter_codigo_futures/data/data_future.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future<String> getName() async {
  //   return "Ramón";
  // }

  List<Map<String,dynamic>> people = [];
  DataFuture dataFuture = DataFuture();

  String text = "Hola";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getName().then((value) {
    //   text = value;
    //   setState((){});
    // });
    getData();
  }

  getData() {
    // text = await getName();
    dataFuture.getDataList().then((value) {
      people = value;
      setState((){});
    });
  }

  Future<String> getName() async {
    return Future.delayed(Duration(seconds: 3), () {
      return "Ramon";
    });
  }

  // Future<String> getName() async {
  //   return Future.delayed(Duration(seconds: 3), () {
  //     return "Ramon";
  //   });
  // }

  Future<List> getProducts() async {
    return Future.delayed(Duration(seconds: 3), () {
      return ["Manzana", "Papaya", "Piña", "Pera"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Futures"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(
              Icons.update,
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: people.length,
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              title: Text(people[index]["fullName"]),
            );
          },
      ),

      // FutureBuilder(
      //   future: dataFuture.getDataList(),
      //   builder: (BuildContext context, AsyncSnapshot snap) {
      //     if (snap.hasData) {
      //       List<Map<String, dynamic>> people = snap.data;
      //       print("Holaaaaaa");
      //       return ListView.builder(
      //         itemCount: people.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           return ListTile(
      //             title: Text(people[index]["fullName"]),
      //             subtitle: Text(people[index]["address"]),
      //           );
      //         },
      //       );
      //
      //       // return ListView.builder(
      //       //     itemCount: products.length,
      //       //     itemBuilder: (BuildContext context, int index) {
      //       //       return ListTile(
      //       //         title: Text(products[index]),
      //       //       );
      //       //     });
      //     }
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //     // print(snapshot);
      //     // print(snapshot.hasData);
      //     // print(snapshot.data);
      //   },
      // ),

      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         text,
      //         style: TextStyle(
      //           fontSize: 30,
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 12,
      //       ),
      //       ElevatedButton(
      //         onPressed: () async {
      //           text = await getName();
      //           setState(() {});
      //         },
      //         child: Text("Mostrar"),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
