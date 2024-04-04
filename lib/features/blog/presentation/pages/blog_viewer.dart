import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/blog.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(builder: (context) =>  BlogViewerPage(blog: blog,),);
  const BlogViewerPage({super.key, required this.blog});
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(blog.title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                const SizedBox(height: 20,),
                Text('By ${blog.posterName}',style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                const SizedBox(height: 5,),
                Text('${formatDateByDDMMYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',style: const TextStyle(color: AppPallete.greyColor,fontSize: 16),),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: ClipRRect(

                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(blog.imageUrl,fit: BoxFit.fitWidth,
                    frameBuilder:(context, child, frame, wasSynchronouslyLoaded) {
                      if (frame != null) {
                          return child;
                        }
                        return const Center(child: CircularProgressIndicator());
                    },),

                  ),
                ),
                const SizedBox(height: 20,),
                Text(blog.content,style: const TextStyle(fontSize: 16,height: 2),)


              ],
            ),
          ),
        ),
      ),
    );
  }
}
