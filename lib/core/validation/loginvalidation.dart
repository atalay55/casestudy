import 'package:casestudy/core/controller/httpcontroller.dart';

import '../../entity/message.dart';
import '../../entity/user.dart';

class LoginValidator{
  Message msg=Message();
  List<User> users=[];
  User? user;


  Future<Message> findPerson(String email,String pass)async {
    users = await HttpController().getAllUser();
    msg.isCorrect = false;
    msg.message = "wrong user";
    for (User p in users) {
      if (p.email == email && p.lastName == pass) {
        msg.isCorrect = true;
        msg.message = "valid user";
      }

    }  return msg;
  }
  checkUserName(String email) {
    Message msg = Message();
    if (email.isEmpty) {
      msg.message = "kullanıcı adı boş geçilemez";
      msg.isCorrect = false;
      return msg.message;
    }
    if (email.length < 3) {
      msg.message = "kullanıcı adı 3 kelimeden fazla olmalıdır";
      msg.isCorrect = false;
      return msg.message;
    }
    if (email.startsWith(RegExp(r"[0123456789]"))) {
      msg.message = "kullanıcı adı sayı ile başlayamaz";
      msg.isCorrect = false;
      return msg.message;
    }
    msg.isCorrect = true;
    return null;
  }

  checkPass(String pass) {
    Message msg = Message();
    if (pass.isEmpty) {
      msg.message = "sifre alani bos gecilemez";
      msg.isCorrect = false;
      return msg.message;
    }

    msg.isCorrect = true;
    return null;
  }

}