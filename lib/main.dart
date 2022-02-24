import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataApi(),
    );
  }
}

class DataApi extends StatefulWidget {
  @override
  _DataApiState createState() => _DataApiState();
}

class _DataApiState extends State<DataApi> {

  getData() async{
    var respones = await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(respones.body);
    List <User> users = [];

    for(var u in jsonData){
      User user = User(u['name'], u['email'], u['userName']);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('Data'),
      ),
      body: Container(
        child: Card(child: FutureBuilder(future: getData(),
        builder: (context, snapshot){
          if(snapshot.data == null){
            return Container(
              child: Center(
                child: Text('Loading'),
              ),
            );
          }else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i){
              return ListTile(
                title: Text(snapshot.data[i].name),
                subtitle: Text(snapshot.data[i].userName),
                trailing: Text(snapshot.data[i].email),
              );
            });
          }
        },),),
      ),
    );
  }
}

class User {
  final String name, email, userName;

  User(this.name, this.email, this.userName);
}
