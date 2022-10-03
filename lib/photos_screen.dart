import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  List<Photos> _photosList = [];
  List<Photos> get photosList{
    return _photosList;
  }
  Future<List<Photos>> getPhotos() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'), 
    headers: {
      'Content-Type' : 'application/json; charset=utf-8',
      'Connection' : 'keep-alive',
    });
    var data = json.decode(response.body);
    if(response.statusCode == 200){
    for(Map i in data){
      Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
      photosList.add(photos);
    }
    return photosList;
    }
    else{

      return photosList;
    }
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Api'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context,AsyncSnapshot<List<Photos>> snapshot) {
              return ListView.builder(
                itemCount: photosList.length,
                itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                  ),
                  title: Text('Notes id: '+snapshot.data![index].id.toString()),
                  subtitle: Text(snapshot.data![index].title.toString()),
                );
              },
              );
            },
            ),
          )
        ],
      ),
    );
  }
}

class  Photos{
  String title, url;
  int id;
  Photos({required this.title, required this.url,required this.id});
}