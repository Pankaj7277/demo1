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
          if (widget.isSearch == true) {
            _articles = data['response']['docs'];
          } else {
            _articles = data['results'];
          }
          _isLoading = false;
        });

        debugPrint(_articles.toString());
      } else {
        throw Exception('Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
      debugPrint('Error: $_error');
    }
  }


  String buildUrl() {
    if (widget.isSearch) {
      return 'https://api.nytimes.com/svc/search/v2/articlesearch.json?q=${widget.searchValue}&api-key=83SdRzKA36oUu7ATaGw9VnGWF64KROWk';
    } else {
      return 'https://api.nytimes.com/svc/mostpopular/v2/${widget.type}/7.json?api-key=83SdRzKA36oUu7ATaGw9VnGWF64KROWk';
    }
  }

  @override
  void initState() {
    super.initState();
    final url = buildUrl();
    fetchApi(url: url);
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

                    final title = widget.isSearch == true
                        ? article['headline']['main']
                        : article['title'];

                    final date = widget.isSearch == true
                        ? article['pub_date']
                        : article['published_date'];
                    return ListTile(
                      title: Text(title ?? 'No Title'),
                      subtitle: Text(date ?? 'No Date'),
                    );
                  }),
    );
  }
}
