import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/UserModel.dart';
class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = json.decode(response.body);
    if(response.statusCode == 200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else{
      return userList;
    }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Api'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                future: getUserApi(),
                  builder: (context,AsyncSnapshot<List<UserModel>> snapshot) {
                  if(!snapshot.hasData)
                    {
                      return Center(
                        child: CircularProgressIndicator(),);
                    }else{
                    return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReuseableRow(title: 'Name', value: snapshot.data![index].name.toString(),),
                              ReuseableRow(title: 'Username', value: snapshot.data![index].username.toString(),),
                              ReuseableRow(title: 'Email', value: snapshot.data![index].email.toString(),),
                              ReuseableRow(title: 'Address', value: snapshot.data![index].address!.city.toString()
                                + snapshot.data![index].address!.geo!.lat.toString(),),
                            ],
                          ),
                        ),
                      );
                    },);
                  }
                  },),),
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
