import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),

      body: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (context,snapShot){
          if(snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapShot.data == null){
            return const Center(child: Text('No data found',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),);
          }else {
            Map<String,dynamic> data = snapShot.data!.data()!;
            print(data['image_url']);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50,bottom: 20),
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                        data['image_url'],
                    ),
                  ),
                ),
                Text(data['name'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.email,color: Colors.green,),
                      const SizedBox(width: 10,),
                      Text(data['email'],style: const TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text('Status',
                    textAlign: TextAlign.left,
                    style:  TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Divider(thickness: 2,),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 10),
                  child:  Text(data['status'],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            );
          }


        },
      ),
    );
  }
}
