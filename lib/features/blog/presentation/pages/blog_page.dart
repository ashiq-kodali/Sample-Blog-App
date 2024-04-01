import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Blogs"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, AddNewBlogPage.route());
          }, icon: const Icon(CupertinoIcons.add_circled,)),
        ],
      ),body: const SafeArea(child: Center(child: Text('Home '),)),
    );
  }
}
