import 'package:flutter/material.dart';
import 'package:flutter_demos/sqlite/data/dbhelper.dart';
import 'package:flutter_demos/sqlite/models/user.dart';

class AdminPage extends StatelessWidget {
  AdminPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  String fullName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sqlite'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SizedBox(
                    height: 300,
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                          onChanged: (text) {
                            fullName = text;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Nombre Completo'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, llene este campo';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                DBHelper.instance.create(User(
                                    fullName: fullName,
                                    createdTime: DateTime.now()));
                              }
                            },
                            child: const Text('submit'))
                      ]),
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Text('jola'),
      ),
    );
  }
}
