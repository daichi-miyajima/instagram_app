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
              DropdownButton(
                items: const [
                  DropdownMenuItem(
                    child: Text('映画'),
                    value: 'movie',
                  ),
                  DropdownMenuItem(
                    child: Text('旅行'),
                    value: 'travel',
                  ),
                  DropdownMenuItem(
                    child: Text('サウナ'),
                    value: 'sauna',
                  ),
                ],
                onChanged: (String? value) {
                  addModel.setGenre(value!);
                  addModel.fetchFirebaseData();
                },
                //7
                value: addModel.genre,
              ),
              ElevatedButton(
                onPressed: () async {
                  // 画像アップロード処理
                  await addModel.addToFirebase();
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
