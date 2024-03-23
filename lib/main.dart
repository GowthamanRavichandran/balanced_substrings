import 'package:flutter/material.dart';

void main() {
  runApp(const BalancedString());
}

class BalancedString extends StatefulWidget {
  const BalancedString({super.key});

  @override
  State<BalancedString> createState() => _BalancedStringState();
}

class _BalancedStringState extends State<BalancedString> {
  final TextEditingController _controller = TextEditingController();
  List<String> _balancedSubstring = [];
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Balanced Substring'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    onTapOutside: (event) {
                      _focusNode.unfocus();
                    },
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      enabledBorder: _getBorderForTextField(Colors.blue),
                      focusedBorder: _getBorderForTextField(Colors.blue),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Heebo',
                          height: 1,
                          fontWeight: FontWeight.w400),
                      labelText: 'Enter the string :',
                    ),
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    if (_controller.text.isNotEmpty) {
                      _balancedSubstring =
                          getBalancedSubstrings(_controller.text);
                    }
                    setState(() {
                      _controller.clear();
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.teal),
                    child: const Center(
                      child: Text(
                        'Get',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.32,
                            fontFamily: 'Heebo'),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                    'The balanced substring for your input are : $_balancedSubstring'),
              )
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _getBorderForTextField(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }
}

List<String> getBalancedSubstrings(String inputString) {
  List<String> balancedSubstring = [];

  for (int i = 0; i < inputString.length; i++) {
    for (int j = i + 1; j < inputString.length; j++) {
      String substring = inputString.substring(i, j + 1);
      if (isBalancedString(substring)) {
        if (substring.length > 1 &&
            substring.length >=
                (balancedSubstring.isNotEmpty
                    ? balancedSubstring.first.length
                    : 0)) {
          if (substring.length >
              (balancedSubstring.isNotEmpty
                  ? balancedSubstring.first.length
                  : 0)) {
            balancedSubstring.clear();
          }
          balancedSubstring.add(substring);
        }
      }
    }
  }

  return balancedSubstring;
}

bool isBalancedString(String subString) {
  Set<String> noOfCharacters = subString.split('').toSet();
  if (noOfCharacters.length != 2) {
    return false;
  }

  int firstCharCount = subString.split(noOfCharacters.first).length - 1;
  int secondCharCount = subString.split(noOfCharacters.last).length - 1;

  return firstCharCount == secondCharCount;
}
