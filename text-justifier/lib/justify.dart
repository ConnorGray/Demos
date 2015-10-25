library jusifier;

import 'dart:async';
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:collection' show Queue;

String justify(String text, int cols) {
  List<String> words = text.split(new RegExp(r"\s+"));

  List<String> lines = new List<String>();

  String currentLine = "";

  for (String word in words) {
    if ((currentLine + word).length < cols) {
      if (currentLine == "") {
        currentLine += word;
      } else {
        currentLine += " " + word;
      }
    } else {
      lines.add(currentLine);
      currentLine = word; 
    }
  }

  lines.add(currentLine);

  return lines.join('\n').trim();
}