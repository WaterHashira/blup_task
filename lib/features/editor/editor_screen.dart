import 'package:blup_task/features/editor/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text Editor'),
        ),
        body: SizedBox(
          height: screenSize.height,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                height: screenSize.height / 5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomButton(
                        buttonText: 'Add Text',
                        buttonIcon: Icons.add,
                        onTap: () {
                          //TODO: add the textfield adding functionality
                        }),
                    CustomButton(
                        buttonText: 'Click Photo',
                        buttonIcon: Icons.photo,
                        onTap: () {
                          //TODO: add the app screenshot clicking functionality (and saving it in the device gallary)
                        })
                  ],
                ),
              ),

              //the editor palne:
              Container(
                height: screenSize.height * 4 / 5,
                padding: const EdgeInsets.all(10),
                //child: SingleChildScrollView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
