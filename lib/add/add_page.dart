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
              InkWell(
                onTap: () async {
                  // カメラロール開いて写真選ぶ
                  addModel.pickImage();
                },
                child: SizedBox(
                  width: 100,
                  height: 160,
                  // 選んだ写真を表示
                  child: addModel.imageFile != null
                      ? Image.file(addModel.imageFile!)
                      : Container(
                    color: Colors.grey,
                  ),
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'タイトル',
                ),
                onChanged: (text) {
                  addModel.title = text;
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: '思い出を書こう',
                ),
                onChanged: (text) {
                  addModel.description = text;
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'ジャンル',
                ),
                onChanged: (text) {
                  addModel.genre = text;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  // 画像アップロード処理
                  await addModel.addImage();
                  Navigator.pop(context);
                  addModel.fetchFirebaseData();
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
