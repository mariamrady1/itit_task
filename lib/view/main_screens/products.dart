import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mariam Products'),
      ),
      body: Container(
        child:  FutureBuilder<QuerySnapshot<Map<String,dynamic>>>(
          future: FirebaseFirestore.instance.collection('data').get(),
          builder: (context,snapShot) {
            if(snapShot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }else if (snapShot.data == null){
              return const Center(
                child:  Text('Not data found',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                ),
              );
            }else {
              List<Map<String,dynamic>> data =[];
              snapShot.data!.docs.forEach((element) { 
                data.add(element.data());
              });
              return GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // childAspectRatio: 1.5,
                    mainAxisExtent: 250,
                  ),
                  itemBuilder: (_,index){
                    return Card(
                      elevation: 5,
                      child: Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            Container(
                              height: 110,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(data[index]['image'],fit: BoxFit.fill,),
                              ),
                            ),
                            const SizedBox(height: 5,),
                            FittedBox(
                              child: Text(data[index]['name'],
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text(
                                '${data[index]['price']} \$',
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 5,),
                            ElevatedButton(
                                onPressed: (){
                                  showDialog(context: context, builder: (_)=>AlertDialog(
                                    title: Text(data[index]['name'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ) ,
                                    content: Column(
                                      children: [
                                        Container(
                                          height: 200,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(data[index]['image'],fit: BoxFit.fill,),
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          '${data[index]['price']} \$',
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                         Container(
                                          alignment: Alignment.centerLeft,
                                          child: const Text("Description",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          ),
                                        ),
                                        const Divider(thickness: 2,),
                                        Text(data[index]['description']??'null')
                                      ],
                                    ),
                                  ));
                                },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.orange),
                                foregroundColor: MaterialStateProperty.all(Colors.black),
                              ),
                                child: const Text(
                                  '   Buy Now   '
                                ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
              );
            }
          },

        ),
      ),
    );
  }
}
