import 'package:demo_1/article_listview.dart';
import 'package:demo_1/search.dart';
import 'package:flutter/material.dart';


class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NYT"),),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const  EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Search", style: TextStyle(fontWeight: FontWeight.w500),),
              const Divider(),

              ListTile(
                title: const Text("Search Articles"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Search()));
                },
              ),
              const Divider(),

             const SizedBox(height: 20),
              const Text("Popular", style: TextStyle(fontWeight: FontWeight.w500),),
              const Divider(),
              ListTile(
                title: const Text("Most Viewed"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),

                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ArticleListview(type: "viewed",isSearch: false,)));

                },
              ),
              const Divider(),
              ListTile(
                title: const Text("Most Shared"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),

                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ArticleListview(type: "shared",isSearch: false)));

                },
              ),
            const Divider(),
              ListTile(
                title: const Text("Most Emailed"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16,),

                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ArticleListview(type: "emailed",isSearch: false)));

                },
              ),
              const Divider(),

            ],
          ),
        ),
      ),
    );
  }
}
