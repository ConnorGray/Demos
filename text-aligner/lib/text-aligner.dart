import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:polymer_expressions/polymer_expressions.dart';
import 'package:polymer_expressions/filter.dart';

import 'package:text_aligner/align.dart' as align;

@CustomTag('text-aligner')
class TextAlignerElement extends PolymerElement {
  @observable String inputText = "Write here.";
  @observable String outputText = "";
  @observable int columns = 80;
  @observable String selectedAlignment = "leftAlign";

  final StringToInt asInteger = new StringToInt();

  TextAlignerElement.created() : super.created() {
    _realign();
  }

  void _realign() {
    switch (this.selectedAlignment) {
      case "leftAlign":
        this.outputText = align.leftAlign(this.inputText, this.columns);
        break;
      case "rightAlign":
        this.outputText = align.rightAlign(this.inputText, this.columns);
        break;
      case "center":
        this.outputText = align.center(this.inputText, this.columns);
        break;
      case "justify":
        this.outputText = align.justify(this.inputText, this.columns);
        break;
      default:
        this.outputText = align.leftAlign(this.inputText, this.columns);
    }
  }

  void inputTextChanged() {
    _realign();
  }

  void columnsChanged() {
    _realign();
  }

  void selectedAlignmentChanged() {
    _realign();
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