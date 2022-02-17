import 'package:apimorty/detailPersonnage.dart';
import 'package:apimorty/model/resultat.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List <Resultat> listePersonnage=[];
  late var jsonResponse;
  String apiAdresse = "https://rickandmortyapi.com/api/character";


  Future init(String adresseUrl) async {
    Uri url = Uri.parse(adresseUrl);
    var responseAdresse = await http.get(url);
    jsonResponse = convert.jsonDecode(responseAdresse.body) as Map<String, dynamic>;
    int index = 0;
    while (index < jsonResponse["results"].length) {
      setState(() {
        Resultat resultat = Resultat.json(jsonResponse["results"][index] as Map<String, dynamic>);
        listePersonnage.add(resultat);
      });
      index++;
    }

    if (jsonResponse['info']['next'] != null) {
      init(jsonResponse['info']['next']);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    init(apiAdresse);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: bodyPage()
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget bodyPage(){
    return GridView.builder(
        itemCount: listePersonnage.length,
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context,int index){
          return 
          InkWell(
            child: Hero(
                tag: '${listePersonnage[index].id}', 
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(listePersonnage[index].image),
                          fit: BoxFit.fill
                      )
                  ),



                ),
            ),
            
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return detailPersonnage(personnage: listePersonnage[index]);
                  }
              ));
              
            },
          );
            


        }
    );
  }
}
