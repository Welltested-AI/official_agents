import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:chopper_with_provider/data/post_api_service.dart';
import 'package:chopper_with_provider/single_post_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chopper Blog'),),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final response = await Provider.of<PostApiService>(context, listen: false).postPost({ 'key1': 'value1' });
          print(response.body);
        },),
      body: FutureBuilder<Response>(
        future: Provider.of<PostApiService>(context).getPosts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if(snapshot.connectionState == ConnectionState.done){

            final List posts = json.decode(snapshot.data.bodyString);

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                    onTap: (){
                      _navigateToPost(context, posts[index]['id']);
                    } ,
                title: Text(posts[index]['title']),
                subtitle: Text(posts[index]['body']),
              ));
            },);
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }

      },),

    );
  }
}

void _navigateToPost(BuildContext context, int id){
  Navigator.push(context, CupertinoPageRoute(builder: (context) => SinglePostPage(postId: id,),));
}


