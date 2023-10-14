import 'package:flutter/material.dart';

class MyAutoCompleteMovo extends StatefulWidget {
  const MyAutoCompleteMovo({super.key});

  @override
  State<MyAutoCompleteMovo> createState() => _MyAutoCompleteMovoState();
}

class _MyAutoCompleteMovoState extends State<MyAutoCompleteMovo> {
  bool emFoco = false;
  final List<Map<String, dynamic>> _conforme = [
    {"label": "Conforme", "valor": "C"},
    {"label": "Não Conforme", "valor": "N"},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode.addListener(() {
      setState(() {
        if (myFocusNode.hasFocus) {
          emFoco = true;
        } else {
          emFoco = false;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
  }

  late FocusNode myFocusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          focusNode: myFocusNode,
        ),
        if (emFoco)
          ListView.builder(
            shrinkWrap: true,
            itemCount: _conforme.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  setState(() {
                    controller.text = _conforme[index]["label"];
                    myFocusNode.unfocus();
                    emFoco = false;
                  });
                },
                subtitle: Text(_conforme[index]["valor"]),
                title: Text(_conforme[index]["label"]),
              );
            },
          )
      ],
    );
  }
}
