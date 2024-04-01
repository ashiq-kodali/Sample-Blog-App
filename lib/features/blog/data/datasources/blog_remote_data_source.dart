import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource{
  Future<BlogModel> uploadBloag(BlogModel blog);
}


class BlogRemoteDataSourceImpl implements BlogRemoteDataSource{
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl(this.supabaseClient)
  @override
  Future<BlogModel> uploadBloag(BlogModel blog) async {
    try{
      final blogData =  await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
      
    }catch(e){
      throw ServerException(e.toString());
    }
    
  }
}