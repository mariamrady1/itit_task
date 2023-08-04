import 'package:flutter/material.dart';
import 'package:mariamproject/view/secondry_screens/dev_and_us.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> DevAndUs(isDeveloper: false)));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                ),
                child: Container(
                    width: 200,
                    alignment: Alignment.center,
                    height: 50 ,
                    child: const Text('About Us',
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    ),

                ),
            ),
          ),
          const SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> DevAndUs(isDeveloper: true)));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
              ),
              child: Container(
                width: 200,
                alignment: Alignment.center,
                height: 50 ,
                child: const Text('Developers',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }
}
