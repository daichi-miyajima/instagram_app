import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../user.dart';
import 'add_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPage();
}

class _FeedPage extends State<FeedPage> {

  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _fetchFirebaseData(); // ページ読み込みでfetchする
  }

  void _fetchFirebaseData() async {
    final db = FirebaseFirestore.instance;

    final event = await db.collection("users").get();
    final docs = event.docs;
    final users = docs.map((doc) => User.fromFirestore(doc)).toList();

    setState(() {
      this.users = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('タイムライン')),
      body: ListView(
        children: users
            .map(
              (user) => ListTile(
              title: Text(user.first),
              subtitle: Text(user.last),
              trailing: Text(user.born.toString()),
              onTap: () { // 編集機能
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Select Year"),
                      content: Container(
                        width: 300,
                        height: 300,
                        child: YearPicker(
                          firstDate: DateTime(DateTime.now().year - 300, 1),
                          lastDate: DateTime(DateTime.now().year + 100, 1),
                          initialDate: DateTime.now(),
                          selectedDate: DateTime(user.born),
                          onChanged: (DateTime dateTime) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.id)
                                .update({
                              'born': dateTime.year,
                            });
                            Navigator.pop(context);
                            _fetchFirebaseData();
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              onLongPress: () async {  // 削除機能
                final db = FirebaseFirestore.instance;
                await db.collection("users").doc(user.id).delete();
                _fetchFirebaseData();
              }),
        )
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddPage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _goToAddPage() async {
    await Navigator.push(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => AddPage()),
    );
    _fetchFirebaseData();
  }
}