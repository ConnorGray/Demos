import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:polymer_expressions/polymer_expressions.dart';
import 'package:polymer_expressions/filter.dart';
import 'package:text_justifier/justify.dart' as justify;

@CustomTag('text-justifier')
class TextJustifierElement extends PolymerElement {
  @observable String inputText = "Write here!";
  @observable String outputText = "";
  @observable int columns = 80;

  TextJustifierElement.created() : super.created() {}

  final StringToInt asInteger = new StringToInt();

  void _rejustify() {
    this.outputText = justify.justify(this.inputText, this.columns);
  }

  void inputTextChanged() {
    _rejustify();
  }


  void columnsChanged() {
    _rejustify();
  }
}

class StringToInt extends Transformer<String, int> {
  String forward(int i) => '$i';
  int reverse(String s) {
    if (s == null || s == "") {
      return 0;
    } else {
      return int.parse(s);
    }
  } 
}
