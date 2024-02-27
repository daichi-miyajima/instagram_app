import 'package:flutter/material.dart';
import 'package:instagram/register/register_model.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('新規登録'),
        ),
        body: Center(
          child: Consumer<RegisterModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          // カメラロール開いて写真選ぶ
                          model.pickImage();
                        },
                        child: SizedBox(
                          width: 100,
                          height: 160,
                          // 選んだ写真を表示
                          child: model.imageFile != null
                              ? Image.file(model.imageFile!)
                              : Container(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      TextField(
                        controller: model.nameController,
                        decoration: InputDecoration(
                          hintText: 'Name',
                        ),
                        onChanged: (text) {
                          model.setName(text);
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: model.descriptionController,
                        decoration: InputDecoration(
                          hintText: 'Description',
                        ),
                        onChanged: (text) {
                          model.setDescription(text);
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: model.emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                        ),
                        onChanged: (text) {
                          model.setEmail(text);
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: model.passwordController,
                        decoration: InputDecoration(
                          hintText: 'パスワード',
                        ),
                        onChanged: (text) {
                          model.setPassword(text);
                        },
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          model.startLoading();

                          // 追加の処理
                          try {
                            await model.signUp();
                            Navigator.of(context).pop();
                          } catch (e) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(e.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } finally {
                            model.endLoading();
                          }
                        },
                        child: Text('登録する'),
                      ),
                    ],
                  ),
                ),
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}