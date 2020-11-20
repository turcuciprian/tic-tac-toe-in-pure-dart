import 'dart:io';
import 'dart:core';

bool winner = false;
bool isXturn = true;
int moveCount = 0;
List<String> values = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
List<String> combinations = ['012', '048', '036', '147', '246', '258', '345', '678'];
void main() {
  generateBoard();
  getnextCharacter();
}
//check if a combination is true or false for a player (X or 0)
bool checkCombination(String combination, String checkFor) {
  //split the numbers in a list of integers
  List<int> numbers = combination.split('').map((item) {
    return int.parse(item);
  }).toList();
  bool match = false;
  for (final item in numbers) {
    if (values[item] == checkFor) {
      match = true;
    } else {
      match = false;
      break;
    }
  }
  return match;
}
void checkWinner(player) {
  for (final item in combinations) {
    bool combinationValidity = checkCombination(item, player);
    if (combinationValidity == true) {
      print('$player WON!');
      winner = true;
      break;
    }
  }
}
//get input, check winners
void getnextCharacter() {
  //get input from player
  print('Choose Number for ${isXturn == true ? "X" : "0"}');
  int number = int.parse(stdin.readLineSync());
  //change the value of selected number in values
  values[number - 1] = isXturn ? 'X' : '0';
  //change player turn
  isXturn = !isXturn;
  //increment move count
  moveCount++;
  if (moveCount == 9) {
    winner = true;
    print('DRAW!');
  } else {
    //clear the console
    clearScreen();
    //redraw the board with the new information
    generateBoard();
  }
  //
  //Check Validity for players, declare winner
  //
  //check validity for player X
  checkWinner('X');
  //check validity for player 0
  checkWinner('0');

  //until we have a winner, we call current function again
  if (winner == false) getnextCharacter();
}
//clear console screen
void clearScreen() {
  if (Platform.isWindows) {
    print(Process.runSync("cls", [], runInShell: true).stdout);
  } else {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}
//show current state of board
void generateBoard() {
  print('   |   |   ');
  print(' ${values[0]} | ${values[1]} | ${values[2]} ');
  print('___|___|___');
  print('   |   |   ');
  print(' ${values[3]} | ${values[4]} | ${values[5]} ');
  print('___|___|___');
  print('   |   |   ');
  print(' ${values[6]} | ${values[7]} | ${values[8]} ');
  print('   |   |   ');
}