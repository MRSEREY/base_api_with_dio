import 'package:base_api_with_dio/mixins/api_call_mixin.dart';
import 'package:base_api_with_dio/models/user_model.dart';
import 'package:base_api_with_dio/services/user_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dio Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Dio Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ApiCallMixin {
  List users = [];

  _getUserList() async {
    apiCall(() async {
      UserService userService = UserService();
      List response = await userService.fetchAll();
      setState(() {
        users = response;
      });
    });
  }

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Center(
            child: FlatButton(
              onPressed: () async {
                await _getUserList();
              },
              child: Text('GET USER'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(users[index].profileUrl),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${users[index].firstName} ${users[index].lastName}',
                            ),
                            Text(
                              users[index].email,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
