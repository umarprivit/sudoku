class StackItem {
  int row;
  int column;

  StackItem(this.row, this.column);
}

class stackUndo {
  static List<StackItem> undo = [];

  void push(int row, int column) {
  undo.add(StackItem(row, column));
}
  List<dynamic>? pop() {
    if (undo.isNotEmpty) {
      StackItem item = undo.removeLast();
      return [item.row, item.column];
    }
    return null;
  }

  // Check if the stack is empty
  bool isEmpty() {
    return undo.isEmpty;
  }

  // Get the size of the stack
  int size() {
    return undo.length;
  }
  void clear() {
    undo.clear();
  }
}

