import 'package:flutter/material.dart';
import 'package:flutter_demos/sqlite/data/dbhelper.dart';
import 'package:flutter_demos/sqlite/models/user.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late List<User> _users;

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
                return CreateDialog();
              }).then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<User>>(
        future: DBHelper.instance.findAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _users = snapshot.data!;
            return ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.grey[200],
                    title: Text(_users[index].fullName),
                    trailing: Text(
                        '${_users[index].createdTime.day.toString()}/${_users[index].createdTime.month.toString()}/${_users[index].createdTime.year.toString()}'),
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error :('));
          } else {
            return const Center(child: Text('Cargando...'));
          }
        },
      ),
    );
  }
}

class CreateDialog extends StatelessWidget {
  CreateDialog({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  String fullName = '';

  @override
  Widget build(BuildContext context) {
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
              decoration: const InputDecoration(labelText: 'Nombre Completo'),
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
                    DBHelper.instance.create(
                        User(fullName: fullName, createdTime: DateTime.now()));

                    Navigator.pop(context);

                    const snackBar = SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Usuario creado correctamente!',
                          style: TextStyle(color: Colors.white)),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('Crear'))
          ]),
        ),
      ),
    );
  }
}
