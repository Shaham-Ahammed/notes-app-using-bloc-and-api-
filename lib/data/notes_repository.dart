import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc_note_app_api/data/notes_data_provider.dart';

class NotesRepository {
  final NotesDataProvider dataProvider;

  NotesRepository({required this.dataProvider});

  Future<List<dynamic>> getData() async {
    try {
      final respone = await dataProvider.dataProviderFetchData();
      if (respone.statusCode == 200) {
        final body = respone.body;
        final json = jsonDecode(body);
        return json['items'];
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  submitData(String title, String description) async {
    final body = dataProvider.dataProviderSubmitData(title, description);
    const url = 'https://api.nstack.in/v1/todos';

    final uri = Uri.parse(url);
    try {
      final response = await http.post(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 201) {
        return "success";
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  deleteData(String id) async {
    try {
      final response = await dataProvider.dataProviderDeleteData(id);
      if (response.statusCode == 200) {
        return "success";
      }
    } catch (e) {
      return "failure";
    }
  }

  updateData(String id, String title, String description) async {
    try {
      final url = "https://api.nstack.in/v1/todos/$id";
      final uri = Uri.parse(url);
      final body = dataProvider.dataProviderEditData(title, description);
      final response = await http.put(uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return "success";
      }
    } catch (e) {
      return "failure";
    }
  }
}
