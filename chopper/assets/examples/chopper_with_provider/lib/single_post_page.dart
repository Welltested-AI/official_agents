import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:chopper_with_provider/data/post_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SinglePostPage extends StatelessWidget {

  final int postId;

  const SinglePostPage({Key? key, required  this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('single post ')),
      body: FutureBuilder<Response>(
        future: Provider.of<PostApiService>(context).getPost(postId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if(snapshot.connectionState == ConnectionState.done){

            final Map post = json.decode(snapshot.data.bodyString);

            return Card(
                child: ListTile(
                  title: Text(post['title']),
                  subtitle: Text(post['body']),
                ));
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }

        },),


    );
  }
}
