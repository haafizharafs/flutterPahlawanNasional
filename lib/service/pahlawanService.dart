// ignore_for_file: file_names

import '../model/pahlawan.dart';
import 'package:http/http.dart' as http;

class PahlawanService {
  static const String _baseUrl = 'https://indonesia-public-static-api.vercel.app/api/heroes';

  Future getPahlawan() async {
    Uri urlApi = Uri.parse(_baseUrl);

    final response = await http.get(urlApi);
    if (response.statusCode == 200) {
      return welcomeFromJson(response.body.toString());
    } else {
      throw Exception("Failed to load data pahlawan");
    }
  }
}