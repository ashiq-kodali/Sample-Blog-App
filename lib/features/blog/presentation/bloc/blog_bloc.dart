import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/blog.dart';
import '../../domain/usecases/get_all_blogs.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs}) :_uploadBlog =uploadBlog,_getAllBlogs = getAllBlogs , super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogGetFetchAllBlogs>(_onFetchAllBlogs);



  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParms(
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));
    if (kDebugMode) {
      print(res);
    }
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }
  void _onFetchAllBlogs (BlogGetFetchAllBlogs event,  Emitter<BlogState> emit,)async{

    final res =await _getAllBlogs(NoParams());
    res.fold(
          (l) => emit(BlogFailure(l.message)),
          (r) => emit(BlogDisplaySuccess(r)),
    );
  }
}
