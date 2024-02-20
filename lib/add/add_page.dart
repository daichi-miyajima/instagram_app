import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_model.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AddModel>(
          builder: (context, addModel, child) => Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'First',
                ),
                onChanged: (text) {
                  addModel.first = text;
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Last',
                ),
                onChanged: (text) {
                  addModel.last = text;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  await addModel.addToFirebase();
                  Navigator.pop(context);
                },
                child: Text('追加する'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
