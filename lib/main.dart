import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
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

  List digimons = [];

  getDigimons() async {
    var response = await Dio().get('https://digimon-api.herokuapp.com/api/digimon');
    return response.data;
  }

  @override
  void initState() {
    super.initState();
    getDigimons().then((data){
      setState((){
        digimons = data;
      });
    });
  }
 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Digi Flutter"),
      ),
      body: ListView.builder(
        itemCount: digimons.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            margin: EdgeInsets.all(8),
            color: Colors.purple,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(digimons[index]['img'], scale: 0.5),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(digimons[index]['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  ),
                )
              ],
            )
          );
        },

      )
    );
  }
}
