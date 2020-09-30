import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class Cereales{
  final List<dynamic> cereales;

  Cereales({this.cereales});

  factory Cereales.fromJson(Map<String,dynamic> json){
    return Cereales(
      cereales: json["Cereales"],
    );
  }
}

Future<Cereales> fetchCereales() async{
  final response = await http.get("http://bde878335cad.ngrok.io/api/cereales");
  if(response.statusCode == 200){
    return Cereales.fromJson(json.decode(response.body));
  }else{
    throw Exception("No se encontraron las matriculas");
  }

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Future<Cereales> futureCereales;

  @override
  void initState() {
    super.initState();
    futureCereales = fetchCereales();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  List<Widget> display_cereales(Cereales cereales){
    List<Widget> list = [];
    for (var cereal in cereales.cereales)
      list.add(
        Card(child: Container(child: Row(
          children: [
            Expanded(
                child: Container(
              child:Text(cereal["numero"]),
              width: 200,
            ),
            flex: 1,
            ),
            Expanded(
                child: Text(cereal["Cereal"]),
                    flex: 3,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
            padding: EdgeInsets.all(16),
        ),
        )

      );
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:
          FutureBuilder<Cereales>(
          future: futureCereales,
          builder: (context, snapshot){
            if(snapshot.hasData){
              var cereales = display_cereales(snapshot.data);
              return ListView(children: cereales,);
            }else if(snapshot.hasError){
              return Text("Error");
            }
            return CircularProgressIndicator();
          }
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
