import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<double> getExchangeRate() async {
    final response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/EUR'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['rates']['USD'];
    } else {
      throw Exception('Не удалось загрузить обменный курс');
    }
  }
}
