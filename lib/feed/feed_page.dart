import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../add/add_page.dart';
import 'feed_model.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<FeedModel>(context, listen: false).fetchFirebaseData(); // fetchFirebaseData() を呼び出す
    return Scaffold(
      body: Consumer<FeedModel>(
        builder: (context, feedModel, child) {
          if (feedModel.users.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: feedModel.users
                  .map(
                    (user) => ListTile(
                  // 一旦画像は仮置き
                  leading: user.imageURL != null
                      ? Image.network(user.imageURL!)
                      : null,
                  title: Text(user.first),
                  subtitle: Text(user.last),
                  trailing: Text(user.born.toString()),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Select Year"),
                          content: Container(
                            width: 300,
                            height: 300,
                            child: YearPicker(
                              firstDate:
                              DateTime(DateTime.now().year - 300, 1),
                              lastDate:
                              DateTime(DateTime.now().year + 100, 1),
                              initialDate: DateTime.now(),
                              selectedDate: DateTime(user.born),
                              onChanged: (DateTime dateTime) {
                                feedModel.updateUserBorn(
                                    user.id, dateTime.year);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  onLongPress: () {
                    feedModel.deleteUser(user.id);
                  },
                ),
              )
                  .toList(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          ).then((_) => Provider.of<FeedModel>(context, listen: false)
              .fetchFirebaseData());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}