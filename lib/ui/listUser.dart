import 'package:app_sem13_drift/ui/newUser.dart';
import 'package:flutter/material.dart';
import 'package:app_sem13_drift/database/database.dart';
import 'package:provider/provider.dart';

class listUser extends StatefulWidget {
  const listUser({super.key});
  @override
  State<listUser> createState() => _listUserState();
}

class _listUserState extends State<listUser> {
  late AppDatabase database;

  @override
  Widget build(BuildContext context) {
    database = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("User List..."),
      ),
      body: FutureBuilder<List<User>>(
        future: database.getListUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User>? userList = snapshot.data;
            return ListView.builder(
                itemCount: userList!.length,
                itemBuilder: (context, index) {
                  User userData = userList[index];
                  return ListTile(
                    title: Text(userData.name),
                    subtitle: Text(userData.email),
                  );
                });
          } else {
            return Center(
              child: Text(""),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUser();
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
    );
  }

  void addUser() async {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => newUser()),
    );

    if (res != null && res == true) {
      setState(() {});
    }
  }
}
