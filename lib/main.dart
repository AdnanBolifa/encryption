import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cipher Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CipherCalculator(),
    );
  }
}

class CipherCalculator extends StatefulWidget {
  @override
  _CipherCalculatorState createState() => _CipherCalculatorState();
}

class _CipherCalculatorState extends State<CipherCalculator> {
  TextEditingController inputController = TextEditingController();
  TextEditingController outputController = TextEditingController();

  String caesarEncrypt(String input, int shift) {
    String result = "";
    for (int i = 0; i < input.length; i++) {
      if (input[i].toUpperCase().codeUnitAt(0) >= 65 &&
          input[i].toUpperCase().codeUnitAt(0) <= 90) {
        result += String.fromCharCode((input[i].toUpperCase().codeUnitAt(0) +
                shift -
                65) %
            26 +
            65);
      } else if (input[i].toUpperCase().codeUnitAt(0) >= 97 &&
          input[i].toUpperCase().codeUnitAt(0) <= 122) {
        result += String.fromCharCode((input[i].toUpperCase().codeUnitAt(0) +
                shift -
                97) %
            26 +
            97);
      } else {
        result += input[i];
      }
    }
    return result;
  }

  String hillEncrypt(String input, List<List<int>> key) {
    String result = "";
    List<int> plainText = [];
    List<int> cipherText = [];

    for (int i = 0; i < input.length; i++) {
      plainText.add(input.codeUnitAt(i) - 65);
    }

    for (int i = 0; i < plainText.length; i += key.length) {
      for (int j = 0; j < key.length; j++) {
        int sum = 0;
        for (int k = 0; k < key.length; k++) {
          sum += key[j][k] * plainText[i + k];
        }
        cipherText.add(sum % 26);
      }
    }

    for (int i = 0; i < cipherText.length; i++) {
      result += String.fromCharCode(cipherText[i] + 65);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cipher Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: inputController,
              decoration: InputDecoration(labelText: "Input"),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        outputController.text = caesarEncrypt(
                            inputController.text, 3); // Change shift here
                      });
                    },
                    child: Text("Caesar Encrypt"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        outputController.text = hillEncrypt(
                            inputController.text, [
                          [6, 24, 1],
                          [13, 16, 10],
                          [20, 17, 15]
                        ]); // Change key here
                      });
                    },
                    child: Text("Hill Encrypt"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: outputController,
              readOnly: true,
              decoration: InputDecoration(labelText: "Output"),
            ),
          ],
        ),
      ),
    );
  }
}
