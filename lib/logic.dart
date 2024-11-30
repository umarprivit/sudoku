// ignore_for_file: camel_case_types

import 'dart:math';

class logic {
  static List<List<int>> arr = List.generate(9, (_) => List.filled(9, 0));
  static List<List<String>> filledarr = List.generate(9, (_) => List.filled(9, ""));
  static List<List<List<int>>> notes = List.generate(9, (_) => List.generate(9, (_) => List<int>.empty(growable: true)));

  bool checkH(int x, int num) {
    for (int i = 0; i < 9; i++) {
      if (arr[x][i] == num) {
        return false;
      }
    }
    return true;
  }

  bool checkV(int x, int num) {
    for (int i = 0; i < 9; i++) {
      if (arr[i][x] == num) {
        return false;
      }
    }
    return true;
  }

  bool check3by3(int r, int c, int num) {
    int br = r - (r % 3);
    int bc = c - (c % 3);
    for (int i = br; i < br + 3; i++) {
      for (int j = bc; j < bc + 3; j++) {
        if (arr[i][j] == num) {
          return false;
        }
      }
    }
    return true;
  }

  bool draw() {
    Random rd = Random();
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        arr[i][j] = 0;
      }
    }
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        int num = rd.nextInt(9) + 1;
        int take = 0;
        while (!(checkH(i, num) && checkV(j, num) && check3by3(i, j, num))) {
          num = rd.nextInt(9) + 1;
          take++;
          if (take > 100) return false;
        }
        arr[i][j] = num;
      }
    }
    return true;
  }

  void generate() {
    bool data = true;
    do {
      data = draw();
      if (data) {
        break;
      }
    } while (true);
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        filledarr[i][j] = arr[i][j].toString();
      }
    }
  }

  void generatePuzzle(int num) {
    generate();
    Random rd = Random();
    int x = 0;
    do {
      int b = rd.nextInt(9);
      int c = rd.nextInt(9);
      if (arr[b][c] != 0) {
        x++;
        arr[b][c] = 0;
      }
    } while (x != num);
  }

  void initializeNotes() {
    notes = List.generate(9, (_) => List.generate(9, (_) => List<int>.empty(growable: true)));
  }

  void addNoteAt(int row, int column, int note) {
    notes[row][column].add(note);
  }

  void removeNoteAt(int row, int column, int note) {
    notes[row][column].remove(note);
  }
}
