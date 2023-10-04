import 'package:casestudy/core/controller/httpcontroller.dart';
import 'package:casestudy/entity/participant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import '../entity/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomePage"),),
      // bahsettiğiniz katılımcıların tam anlamadığım için hem login için get yazdım hemde user için
      body:FutureBuilder<List<User>>(
        future: HttpController().getAllUser(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(child: Text("404"),);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else{
              // users olarak çektiğim data
              return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text("${snapshot.data![index].firstName} ${snapshot.data![index].lastName}",textAlign: TextAlign.center,),

                    subtitle: Text(" ${snapshot.data![index].email}",textAlign: TextAlign.center,),
                    leading: Image.network(
                      snapshot.data![index].avatar, // Resim URL'sini buraya ekleyin
                      width: 100, // Resmin genişliği
                      height: 100, // Resmin yüksekliği
                      fit: BoxFit.cover, // Resmin nasıl sığdırılacağını belirtin
                    ),
                  ),
                );
              },
            );
          }
        })/*,

        // login den direk get yaptığım data burda bulunmaktadır.
      FutureBuilder<List<Participant>>(
          future: HttpController().getparticip(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Center(child: Text("404"),);
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
            else{

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(snapshot.data![index].name,textAlign: TextAlign.center,),
                      subtitle: Text(" ${snapshot.data![index].color}",style: TextStyle(color: HexColor(snapshot.data![index].color),),textAlign: TextAlign.center,),
                      trailing: Text(" ${snapshot.data![index].year}"),
                      leading:Text(" ${snapshot.data![index].pantoneValue}") ,
                    ),
                  );
                },
              );
            }
          }),
      */

      );

  }
}
