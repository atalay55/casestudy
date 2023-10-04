
import 'package:casestudy/core/controller/httpcontroller.dart';
import 'package:riverpod/riverpod.dart';

import '../../entity/user.dart';
class RiverpodController{



  final participantsProvider = FutureProvider<List<User>>((ref) async {
    final response = await HttpController().getAllUser();

    if (response.isNotEmpty ) {

      return response;
    } else {
      throw Exception('Katılımcıları getirme başarısız oldu.');
    }
  });
}