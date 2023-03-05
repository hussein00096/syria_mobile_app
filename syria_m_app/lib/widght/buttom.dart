import 'package:flutter/material.dart';

import '../constant/constant.dart';


class Buttom extends StatefulWidget {
  final String text;
  final Function function;
  final String successMessage;
  final String errorMessage;


  Buttom({

    Key? key,
    required this.text,
    required this.function,
    required this.successMessage,
    required this.errorMessage,
  
    


  });

  @override
  State<Buttom> createState() => _ButtomState();
}

class _ButtomState extends State<Buttom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text(
          widget.text,
          style: mybuttomtextstyle,
        ),
        onPressed: () async {
          try {
            bool result = await widget.function();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result ? widget.successMessage : widget.errorMessage),
                duration: Duration(seconds: 3),
                backgroundColor: result
                    ? Color.fromARGB(255, 30, 171, 9)
                    : Color.fromARGB(255, 255, 0, 0),
              ),
            );
            
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(widget.errorMessage),
                duration: Duration(seconds: 3),
                backgroundColor: Color.fromARGB(255, 255, 0, 0),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
