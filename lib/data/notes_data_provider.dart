import 'package:http/http.dart' as http;

class NotesDataProvider {
  Future<http.Response> dataProviderFetchData() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    return response;
  }

  Map<String, String> dataProviderSubmitData(String title, String description) {
    final body = {"title": title, "description": description};
    return body;
  }

  Future<http.Response> dataProviderDeleteData(String id) async {
    try {
      final url = 'https://api.nstack.in/v1/todos/$id';
      final uri = Uri.parse(url);

      final response = await http.delete(uri);
      return response;
    } catch (e) {
      return http.Response('error deleting data:$e', 500);
    }
  }
  
  Map<String, String> dataProviderEditData(String title, String description) {
    final body = {"title": title, "description": description};
    return body;
  }


}
