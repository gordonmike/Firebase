import 'package:coffee_dan/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffee_dan/services/database.dart';
import 'package:provider/provider.dart';
import 'package:coffee_dan/screens/home/coffee_list.dart';
import 'package:coffee_dan/models/brew.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Coffee>?>.value(
      value: DatabaseService(uid: '').coffee,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffee Dan'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout'),
            )
          ],
        ),
        body: CoffeeList(),
      ),
    );
  }
}
