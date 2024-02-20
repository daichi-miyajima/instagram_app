import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late String first;
  late String last;

  @override
  void initState() {
    super.initState();
    first = '';
    last = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'First',
              ),
              onChanged: (text) {
                setState(() {
                  first = text;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Last',
              ),
              onChanged: (text) {
                setState(() {
                  last = text;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await _addToFirebase();
                Navigator.pop(context);
              },
              child: Text('追加する'),
            ),
          ],
        ),
      ),
    );
  }

  // データの追加
  Future<void> _addToFirebase() async {
    final db = FirebaseFirestore.instance;

    final user = <String, dynamic>{
      "first": first,
      "last": last,
      "born": 1991,
    };

    await db.collection("users").add(user);
  }
}
