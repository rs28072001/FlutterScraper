import 'package:flutter/material.dart';
import 'services/scraper_service.dart';
import 'services/excel_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RTO Agent Scraper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScraperService _scraperService = ScraperService();
  final ExcelService _excelService = ExcelService();
  bool _isLoading = false;

  void _scrapeAndExport() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Map<String, String>> agents = await _scraperService.scrapeRTOAgents();
      _excelService.exportToExcel(agents);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RTO Agent Scraper'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _scrapeAndExport,
                child: Text('Scrape and Export to Excel'),
              ),
      ),
    );
  }
}
