// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pahlawan_nasional_haafizharafs/view/search.dart';

import 'model/pahlawan.dart';
import 'service/pahlawanService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PAHLAWAN NASIONAL',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future data;
  List<Welcome> data2 = [];
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();

  @override
  void initState() {
    data = PahlawanService().getPahlawan();
    data.then((value) {
      setState(() {
        data2 = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: !isSearching ? const Text('PAHLAWAN NASIONAL')
        : TextField(
          controller: searchText,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: "Pencarian",
            hintStyle: TextStyle(color: Colors.grey)
          ),
          onSubmitted: (value){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPahlawan(keyword: searchText.text)));
          },
        ),
       actions: [
        IconButton(onPressed: (){
          setState(() {
            isSearching = !isSearching;
          });
        }, icon: !isSearching ? Icon(Icons.search) : Icon(Icons.cancel))
       ],),
       body: data2.isEmpty ? Center(child: CircularProgressIndicator(color: Colors.black,),)
       : ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data2[index].name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 10),                                            
                    Text(
                      'Tahun Lahir: ${data2[index].birthYear}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600
                      ),
                    ),                      
                    Text(
                      'Tahun Meninggal: ${data2[index].deathYear}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600
                      ),
                    ),
                    Text(
                      'Tahun Penetapan: ${data2[index].ascensionYear}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600
                      ),
                    ),
                    SizedBox(height: 5),                      
                    Text(
                      'Deskripsi: ${data2[index].description}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600
                      ),
                    ),                                            
                  ],
                ),
            ),
          );
        },
          itemCount: data2.length,
       ),
    );
  }
}
