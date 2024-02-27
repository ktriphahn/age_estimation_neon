import 'package:age_estimation_neon/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EstimationRepository {
  Future<User> getEstimationForUser({required String name}) async {
    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=$name'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      final User user = User(
          count: userData['count'] as int,
          name: userData['name'] as String,
          age: userData['age'] as int);
      return user;
    } else {
      throw Exception(
          'Fehler beim Laden der Nutzerdaten: ${response.statusCode}');
    }
  }
}
