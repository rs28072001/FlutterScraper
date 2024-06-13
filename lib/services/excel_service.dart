import 'package:excel/excel.dart';
import 'dart:typed_data';
import 'dart:html' as html;

class ExcelService {
  void exportToExcel(List<Map<String, String>> data) {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    sheetObject.appendRow(['Name', 'Phone Number']);
    for (var agent in data) {
      sheetObject.appendRow([agent['name'], agent['phone']]);
    }

    final List<int> bytes = excel.encode()!;
    final Uint8List byteData = Uint8List.fromList(bytes);
    final blob = html.Blob([byteData]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "rto_agents.xlsx")
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
