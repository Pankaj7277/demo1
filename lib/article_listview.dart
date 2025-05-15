import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ArticleListview extends StatefulWidget {
  final String type;
  final bool isSearch;
  final String? searchValue;
  const ArticleListview(
      {required this.type, super.key, required this.isSearch, this.searchValue});

  @override
  State<ArticleListview> createState() => _ArticleListviewState();
}

class _ArticleListviewState extends State<ArticleListview> {
  List<dynamic> _articles = [];
  bool _isLoading = true;
  String? _error;
  String updatedUrl = "";

  Future<void> fetchApi({required String url}) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _articles = data['results'];
          _isLoading = false;
          debugPrint(_articles.toString());
        });
      } else {
        throw Exception(
            'Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
        debugPrint(_error);
      });
    }
  }

  updateUrl() {
    if (widget.isSearch != true) {
      updatedUrl =
          "https://api.nytimes.com/svc/mostpopular/v2/${widget.type}/7.json?api-key=83SdRzKA36oUu7ATaGw9VnGWF64KROWk";
    } else {
      updatedUrl =
      'https://api.nytimes.com/svc/search/v2/articlesearch.json?q=${widget.searchValue}&api-key=83SdRzKA36oUu7ATaGw9VnGWF64KROWk';
  }
    print(updatedUrl);
  }

  @override
  void initState() {
    super.initState();
    print(widget.searchValue);
    updateUrl();
    fetchApi(url: updatedUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _error != null
              ? Center(
                  child: Text(_error!),
                )
              : ListView.builder(
                  itemCount: _articles.length,
                  itemBuilder: (context, index) {
                    final article = _articles[index];
                    return ListTile(
                      title: Text(article['title'] ?? 'No Title'),
                      subtitle: Text(article['published_date'] ?? 'No Date'),
                    );
                  }),
    );
  }
}
