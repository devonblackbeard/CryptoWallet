import 'package:cryptowallet/net/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../net/api_methods.dart';
import 'add_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    getValues();
  }

  getValue(String id, double amount) {
    if(id == "Bitcoin") {
      return bitcoin * amount;
    }
    if(id == "Ethereum") {
      return ethereum * amount;
    }
    if(id == "Tether") {
      return tether * amount;
    }
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => addCoin(),
        mini: true,
        tooltip: "Add Coin",
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection('Coins')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width/1.3,
                      height: MediaQuery.of(context).size.height/12,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),
                      color: Colors.blue                  
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 5.0),
                        Text("Coin: ${document.id}", style: const TextStyle(color: Colors.white),),
                        Text("\$${getValue(document.id, document.data()['Amount'])}", style: const TextStyle(color: Colors.white)),
                        IconButton(icon: const Icon(Icons.close, color: Colors.red), onPressed: () { removeCoin(document.id); },),
                        
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  addCoin() {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => const AddView())));
  }
  
  
  void getValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");

    setState(() {
      
    });
  }

}
