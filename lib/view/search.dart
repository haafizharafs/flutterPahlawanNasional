import 'package:flutter/material.dart';
import 'package:pahlawan_nasional_haafizharafs/model/pahlawan.dart';
import 'package:pahlawan_nasional_haafizharafs/service/pahlawanService.dart';

// ignore: must_be_immutable
class SearchPahlawan extends StatefulWidget {
  late String keyword;

  SearchPahlawan({super.key, required this.keyword});

  @override
  State<SearchPahlawan> createState() => _SearchPahlawanState();
}

class _SearchPahlawanState extends State<SearchPahlawan> {
  late Future data;
  List<Welcome> data2 = [];
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();
  bool cekData = true;  

  @override
  void initState() {
    data = PahlawanService().getPahlawan();
    data.then((value) {
      setState(() {
        data2 = value;
        data2 = data2.where(
          (element) => element.name.toLowerCase().contains(widget.keyword.toLowerCase()) 
          || element.birthYear.toString().toLowerCase().contains(widget.keyword.toLowerCase()) 
          || element.deathYear.toString().toLowerCase().contains(widget.keyword.toLowerCase()) 
          || element.ascensionYear.toString().toLowerCase().contains(widget.keyword.toLowerCase())).toList();
        if (data2.isEmpty) {
          cekData = false;
        }
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
        title: !isSearching ? const Text('HASIL PENCARIAN')
        : TextField(
          controller: searchText,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
            hintText: "Pencarian",
            hintStyle: TextStyle(color: Colors.grey)
          ),
          onSubmitted: (value){},
        ),
       actions: [
        IconButton(onPressed: (){
          setState(() {
            isSearching = !isSearching;
          });
        }, icon: !isSearching ? const Icon(Icons.search) : const Icon(Icons.cancel))
       ],),
       body: data2.isEmpty 
       ? cekData ? const Center(
        child: CircularProgressIndicator(color: Colors.black,),
        ) : const Center(
          child: Text(
            "Pencarian Tidak Ditemukan",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white
              ),
        ),)
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
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10),                                            
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
                    const SizedBox(height: 5),                      
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