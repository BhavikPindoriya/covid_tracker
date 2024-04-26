import 'dart:convert';

import 'package:covid_tracker/Model/word_state_model.dart';
import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServies {
  Future<WordStateModel> fecthworkedStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.wordStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return WordStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> CountresListApi() async {
    final response = await http.get(Uri.parse(AppUrl.CountriesList));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception('Error');
    }
  }
}
