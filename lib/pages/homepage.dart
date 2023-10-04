import 'package:casestudy/core/controller/httpcontroller.dart';
import 'package:casestudy/core/riverpod/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/user.dart';
final helloWorldProvider = Provider((_) => 'Hello world');
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context ) {

  return Scaffold(
      appBar: AppBar(title: Text("HomePage"),
      backgroundColor: Colors.black87),
      body:
      // bahsettiğiniz katılımcıların tam anlamadığım için hem api/login isteğinin cevapına göre
      // hemde  api/users cevabına göre bir widget yazdım
      FutureBuilder<List<User>>(
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
                final user = snapshot.data![index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      "${user.firstName} ${user.lastName}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18, // Başlık metni boyutu
                        fontWeight: FontWeight.bold, // Kalın yazı
                      ),
                    ),
                    subtitle: Text(
                      user.email,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey, // Altlık metni rengi
                      ),
                    ),
                    leading: CircleAvatar(
                    radius: 30, // Yarıçap boyutu (genişlik ve yükseklik 2 katıdır)
                    backgroundColor: Colors.transparent, // Arka plan rengi
                    child: ClipOval(
                      child: Image.network(
                        user.avatar,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Resim yüklenirken hata olursa gösterilecek yer tutucu
                          return Icon(
                            Icons.error_outline,
                            size: 100,
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
                  ),

                ),
                );
              },
            );

          }
        })


    /*,
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
    //  ParticipantsList()
      );

  }
}
// burda riverpod ile data çekimi bulunmakta
class ParticipantsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participantsAsyncValue = ref.read(RiverpodController().participantsProvider);

    //print(participantsAsyncValue.hasValue);
    return participantsAsyncValue.when(
      data: (participants) {

        if (participants == null || participants.isEmpty) {
        return Center(child: Text('No data available'));
      }
      return ListView.builder(
        itemCount: participants.length,
        itemBuilder: (context, index) {
          final participant = participants[index];
          return ListTile(
            title: Text(participant.firstName ),
            subtitle: Text(participant.email ),
          );
        },
      );
      },
      loading: () => const Center(child: Text("sdasd")),
      error: (error, stackTrace) => Text(error.toString()),
    );
  }
}