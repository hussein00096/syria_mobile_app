import 'package:flutter/material.dart';
import 'package:syria_m_app/constant/constant.dart';

class CheckboxRow extends StatefulWidget {
  final String text;
  bool checkvalue;
final ValueChanged<bool>? onChanged;

  CheckboxRow({
    required this.text,
    required this.checkvalue,
    required this.onChanged,
   
  });

  @override
  State<CheckboxRow> createState() => _CheckboxRowState();
}

class _CheckboxRowState extends State<CheckboxRow> {
  bool _checkvalue = false;

  @override
  void initState() {
    super.initState();
    _checkvalue = widget.checkvalue;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
            shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5)),
            value: widget.checkvalue,
            onChanged: (value) {
              setState(() {
                _checkvalue = value!;
                widget.onChanged?.call(_checkvalue);
              });
            },
          ),
        ),
        Text(widget.text,style:mycheckTextStyle,),
      ],
    );
  }
}
