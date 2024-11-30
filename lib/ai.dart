// Define constants for players and empty cell
import 'dart:math';

const String playerX = 'X';
const String playerO = 'O';
const String empty = '';

// Define a function to check if a player has won the game
bool checkWin(List<List<String>> board, String player) {
  // Check rows, columns, and diagonals
  return [
    // Rows
    for (int i = 0; i < 3; i++) [for (int j = 0; j < 3; j++) board[i][j]],
    // Columns
    for (int j = 0; j < 3; j++) [for (int i = 0; i < 3; i++) board[i][j]],
    // Diagonals
    [for (int i = 0; i < 3; i++) board[i][i]],
    [for (int i = 0; i < 3; i++) board[i][2 - i]]
  ].any((line) => line.every((cell) => cell == player));
}

// Define a function to check if the game is over
bool gameOver(List<List<String>> board) {
  return checkWin(board, playerX) ||
      checkWin(board, playerO) ||
      board.every((row) => row.every((cell) => cell != empty));
}

// Define a function to evaluate the current board state
int evaluate(List<List<String>> board) {
  if (checkWin(board, playerX)) {
    return 1;
  } else if (checkWin(board, playerO)) {
    return -1;
  } else {
    return 0;
  }
}

int minimax(List<List<String>> board, int depth, bool maximizingPlayer) {
  if (gameOver(board) || depth == 0) {
    return evaluate(board);
  }

  if (maximizingPlayer) {
    int maxEval = -9999; // Negative infinity
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == empty) {
          board[i][j] = playerX;
          int eval = minimax(board, depth - 1, false);
          board[i][j] = empty;
          maxEval = max(maxEval, eval);
        }
      }
    }
    return maxEval;
  } else {
    int minEval = 9999; // Positive infinity
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == empty) {
          board[i][j] = playerO;
          int eval = minimax(board, depth - 1, true);
          board[i][j] = empty;
          minEval = min(minEval, eval);
        }
      }
    }
    return minEval;
  }
}

List<int> findBestMove(List<List<String>> board) {
  int bestEval = -9999; // Negative infinity
  List<int> bestMove = [-1, -1];

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == empty) {
        board[i][j] = playerX;
        int eval = minimax(board, 10, false); // Depth of search
        board[i][j] = empty;
        if (eval > bestEval) {
          bestEval = eval;
          bestMove = [i, j];
        }
      }
    }
  }
  return bestMove;
}
