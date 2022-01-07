import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertodo/tile.dart';

class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState(){
    setState((){});
    super.initState();
  }

  TextEditingController tec = TextEditingController();
  final ffi = FirebaseFirestore.instance;

  Widget taskList(){
    return StreamBuilder<QuerySnapshot>(
      stream: ffi.collection("tasks").snapshots(),
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
          padding: const EdgeInsets.only(top: 16),
          shrinkWrap: true,
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index){
            return TaskTile(
              snapshot.data?.docs[index].get("done"),
              snapshot.data?.docs[index].get("title"),
              snapshot.data!.docs[index].id
            );
          },
        ) : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 32),
            width: 600,
            child: Column(
              children: <Widget>[
                Row(children: [
                  Expanded(
                    child: TextField(
                      controller: tec,
                      decoration: const InputDecoration(hintText: "Zadanie"),
                      onChanged: (val){ setState((){}); },
                    ),
                  ),
                  const SizedBox(width: 16,),
                  tec.text.isNotEmpty ? TextButton(onPressed: (){
                      ffi.collection("tasks").add({
                        "done" : false,
                        "title" : tec.text
                      });
                      tec.text = "";
                    }, child: const Text("DODAJ")) : Container()
                ]),
                taskList()
              ],
            ),
          ),
        ),
      ),
    );
  }

}