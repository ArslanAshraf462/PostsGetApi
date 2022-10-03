import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserSecondScreen extends StatefulWidget {
  const UserSecondScreen({Key? key}) : super(key: key);

  @override
  State<UserSecondScreen> createState() => _UserSecondScreenState();
}

class _UserSecondScreenState extends State<UserSecondScreen> {
  var data;
  Future<void> getUserApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode == 200){
      data = json.decode(response.body);
    }else{

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Api Course'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                future: getUserApi(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: Text('Loading...'),);
                  }else{
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            ReuseableRow(title: 'Name', value: data[index]['name'].toString()),
                            ReuseableRow(title: 'Username', value: data[index]['username'].toString()),
                            ReuseableRow(title: 'Address', value: data[index]['address']['street'].toString()),
                            ReuseableRow(title: 'Lat', value: data[index]['address']['geo']['lat'].toString()),
                            ReuseableRow(title: 'Lng', value: data[index]['address']['geo']['lng'].toString()),
                          ],
                        ),
                      );
                    },);
                  }
          },))
        ],
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title,value;
  ReuseableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}