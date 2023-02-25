import 'package:dbook/common/widgets/text.dart';
import 'package:flutter/material.dart';

//faith 2020年04月20日11:05:57
class NumberControllerWidget extends StatefulWidget {
  //高度
  final double height;

  //输入框的宽度 总体宽度为自适应
  final double width;

  //按钮的宽度
  final double iconWidth;

  //默认输入框显示的数量
  final String numText;

  //点击加号回调 数量
  final ValueChanged? addValueChanged;

  //点击减号回调 数量
  final ValueChanged? removeValueChanged;

  //点击减号任意一个回调 数量
  final ValueChanged? updateValueChanged;


  final int? max;
  final int? min;

  NumberControllerWidget({
    this.height = 30,
    this.width = 40,
    this.iconWidth = 40,
    this.numText = '0',
    this.addValueChanged,
    this.max,
    this.min = 1,
    this.removeValueChanged,
    this.updateValueChanged,
  });

  @override
  _NumberControllerWidgetState createState() => _NumberControllerWidgetState();
}

class _NumberControllerWidgetState extends State<NumberControllerWidget> {
  var textController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    this.textController.text = widget.numText;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: widget.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), border: Border.all(width: 1, color: Colors.black12)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //减号
              _iconButton(icon: Icons.remove, isAdd: false),
              //输入框
              Container(
                width: widget.width,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1, color: Colors.black12),
                        right: BorderSide(width: 1, color: Colors.black12))),
                child: TextField(
                  controller: textController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, height: TextX.h),
                  strutStyle: StrutStyle(
                    fontSize: 12,
                    leading: 0,
                    height: TextX.h,
                    // 1.1更居中
                    forceStrutHeight: true, // 关键属性 强制改为文字高度
                  ),
                  enableInteractiveSelection: false,
                  onChanged: (num) => _valueChanged(num),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 0, top: 2, bottom: 2, right: 0),
                    border: const OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              //加号
              _iconButton(icon: Icons.add, isAdd: true),
            ],
          ),
        )
      ],
    );
  }

  Widget _iconButton({required IconData icon, required bool isAdd}) {
    return Container(
      width: widget.iconWidth,
      child: IconButton(
        padding: EdgeInsets.all(0),
        icon: Icon(icon),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          var text = textController.text.isEmpty ? '0' : textController.text;
          _valueChanged(text, isAdd: isAdd);
        },
      ),
    );
  }

  _valueChanged(String num, {isAdd}) {
    var num = int.parse(textController.text.isEmpty ? '0' : textController.text);

    if(isAdd == null){
      if(widget.max != null && num > widget.max!) num = widget.max!;
      if(widget.min != null && num < widget.min!) num = widget.min!;
      textController.text = '$num';
      textController.selection = TextSelection.fromPosition(TextPosition(offset: textController.text.length));
      if (widget.updateValueChanged != null) widget.updateValueChanged!(num);
      return;
    }

    if (!isAdd && num == 0) return;
    if (isAdd) {
      num++;
      if (widget.addValueChanged != null) widget.addValueChanged!(num);
    } else{
      num--;
      if (widget.removeValueChanged != null) widget.removeValueChanged!(num);
    }

    if(widget.max != null && num > widget.max!) num = widget.max!;
    if(widget.min != null && num < widget.min!) num = widget.min!;

    textController.text = '$num';

    if (widget.updateValueChanged != null) widget.updateValueChanged!(num);
  }
}
