import 'package:flutter/material.dart';

class Sample extends StatefulWidget {
  const Sample({super.key});

  @override
  State<Sample> createState() => _SampleState();
}

List<Map<String, dynamic>> fruit = [
  {
    "name": "apple",
    "cat": "fruit",
    "price": 987.toString(),
    "qty": 87.toString(),
  },
  {
    "name": "apple",
    "cat": "fruit",
    "price": 987.toString(),
    "qty": 87.toString(),
  },
  {
    "name": "apple",
    "cat": "fruit",
    "price": 987.toString(),
    "qty": 87.toString(),
  },
  {
    "name": "apple",
    "cat": "fruit",
    "price": 987.toString(),
    "qty": 87.toString(),
  },
  {
    "name": "apple",
    "cat": "fruit",
    "price": 987.toString(),
    "qty": 87.toString(),
  },
];

class _SampleState extends State<Sample> {
  final TextEditingController controller = TextEditingController();
  late String value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            textField(controller: controller),
            ElevatedButton(
              onPressed: () {
                print(controller.text);
              },
              child: Text("Print"),
            ),
            SizedBox(height: 50),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        tileColor: Colors.blue,
                        trailing: Text(fruit[index]["cat"]),
                        title: Text(fruit[index]["name"]),
                        subtitle: Text(fruit[index]["price"]),
                        leading: Text(fruit[index]["qty"]),
                      ),
                      SizedBox(height: 5),
                    ],
                  );
                },
                itemCount: fruit.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget textField({required TextEditingController controller}) {
  return TextField(
    controller: controller,
    keyboardType: .number,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: 'Enter text',
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    ),
  );
}
