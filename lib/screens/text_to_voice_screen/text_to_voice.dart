import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../constants/app_colors.dart';

class TextToVoice extends StatelessWidget {
  const TextToVoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
          child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width * 3 / 4,
              color: Color.fromARGB(101, 255, 255, 255),
              child: TextField(maxLines: 6, decoration: InputDecoration()),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => new AlertDialog(
                          title: new Text('Text Output'),
                          content: new Text('Output from the backend'),
                          actions: <Widget>[
                            new IconButton(
                                icon: new Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                })
                          ],
                        ));
              },
              child: Text('Convert To Text'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.highlightColor),
              ),
            ),
            Container(
              padding: EdgeInsets.all(30),
              height: 200,
              width: MediaQuery.of(context).size.width * 3 / 4,
              color: Color.fromARGB(101, 255, 255, 255),
              child: Text('Converted Text will be displayed here'),
            ),
          ],
        ),
      )),
    );
  }
}
