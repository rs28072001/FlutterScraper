import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class ScraperService {
  Future<List<Map<String, String>>> scrapeRTOAgents() async {
    final url = 'https://www.hisaronline.in/guide/jewellery-shops-in-hisar';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to load page');
    }

    var document = parse(response.body);
    print(document);
    List<Map<String, String>> agents = [];

    var elements = document.querySelectorAll('.content');
    for (var element in elements) {
      String contentText = element.text.trim();
      print('Content: $contentText'); // Print content to terminal

      agents.add({
        'content': contentText,
      });
    }

    return agents;
  }
}
