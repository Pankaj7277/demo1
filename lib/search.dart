import 'package:demo_1/article_listview.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

 final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          const   SizedBox(height: 50,),
             Padding(
              padding: const  EdgeInsets.all(16.0),
              child: TextField(controller: _controller,
                decoration: const InputDecoration(
                  hintText: "search articles here...",
                  border:  OutlineInputBorder()
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.grey),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                )), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleListview(type: "", isSearch: true,searchValue: _controller.text.toString().trim())));

            },
            child: const Text("Search"),)
          ],
        ),
      )
    );
  }
}
