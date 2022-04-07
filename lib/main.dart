import 'package:flutter/material.dart';

import 'models/contact.dart';

const kDartBlueColor = Color(0xff486579);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite CRUD',
      theme: ThemeData(
        primaryColor: kDartBlueColor,
      ),
      home: const MyHomePage(title: 'SQLite CRUD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phoneNumber;
  final List<Contact> _contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(color: kDartBlueColor),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _form(),
            _list(),
          ],
        ),
      ),
    );
  }

  _form() => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
                validator: (val) {
                  if (val != null && val.isEmpty) {
                    return "Required field";
                  } else if (val == null) {
                    return "Fucking null value";
                  }
                  return null;
                },
                onSaved: (val) => _name = val ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                onSaved: (val) => _phoneNumber = val ?? '',
                validator: (val) {
                  if (val != null && val.isEmpty) {
                    return "Required field";
                  } else if (val == null) {
                    return "null value";
                  } else if (val.length < 10) {
                    return 'At least 10 character';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text(
                    'submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kDartBlueColor),
                  ),
                ),
              )
            ],
          ),
        ),
      );
  _onSubmit() {
    var formCurrentState = _formKey.currentState;
    if (formCurrentState != null) {
      if (formCurrentState.validate()) {
        formCurrentState.save();
        setState(() {
          _contacts.add(
            Contact(name: _name, mobile: _phoneNumber),
          );
        });
        formCurrentState.reset();
      }
    }
  }

  _list() => Expanded(
        child: Card(
          margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: ListView.builder(
            itemBuilder: (context, index) => Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.account_circle,
                    color: kDartBlueColor,
                    size: 40.0,
                  ),
                  title: Text(
                    _contacts[index].name.toUpperCase(),
                    style: const TextStyle(
                        color: kDartBlueColor, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_contacts[index].mobile),
                ),
                const Divider(
                  height: 5.0,
                )
              ],
            ),
            itemCount: _contacts.length,
            padding: const EdgeInsets.all(8),
          ),
        ),
      );
}
