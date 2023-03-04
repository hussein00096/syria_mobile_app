import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../constant/constant.dart';

class felds extends StatefulWidget {
  final String text;
  final TextEditingController textEditingController;

   felds({super.key, 
    required this.text,
    required this.textEditingController,
  });

  @override
  _feldsState createState() => _feldsState();
}

class _feldsState extends State<felds> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: myTextStyle,
        ),
       TextFormField(
   inputFormatters: [

    
  ],
      controller: widget.textEditingController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    )
      ],
    );
  }
}

class FilteringTextInputFormatter {
}