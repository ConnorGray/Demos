library jusifier;

String leftAlign(String text, int cols) {
  List<String> paragraphs = text.split('\n');

  List<String> lines = new List<String>();

  for (String paragraph in paragraphs) {
    List<String> words = paragraph.split(new RegExp(r'\s+'));
    String currentLine = "";

    for (String word in words) {
      if (currentLine.length + 1 + word.length > cols) {
        lines.add(currentLine);
        currentLine = word;
      } else {
        if (currentLine != "") {
          currentLine += " ";
        }
        currentLine += word;
      }
    }

    lines.add(currentLine);
  }


  return lines.join('\n');
}

String rightAlign(String text, int cols) {
  String leftAligned = leftAlign(text, cols);

  List<String> lines = leftAligned.split('\n');

  for (int i = 0; i < lines.length; i++) {
    lines[i] = lines[i].padLeft(cols, ' ');
  }

  return lines.join('\n');
}