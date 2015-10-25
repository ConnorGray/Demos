library solvers;

import 'dart:async';
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:collection' show Queue;

List<List<int>> getMovesIterative(int numDisks) {
  int A = 0, B = 1, C = 2;

  if (numDisks % 2 == 1) {
    B = 2;
    C = 1;
  }

  List<Queue<int>> towers = new List<Queue<int>>()
    ..add(new Queue<int>())
    ..add(new Queue<int>())
    ..add(new Queue<int>());

  for (int i = 0; i < numDisks; i++) {
    towers[A].add(numDisks - i);
  }

  List<List<int>> moves = new List<List<int>>();

  List<int> legalMove(int T1, int T2) {
    if (towers[T1].isEmpty && towers[T2].isEmpty) {
      return null;
    } else if (towers[T1].isEmpty) {
      return [T2, T1];
    } else if (towers[T2].isEmpty) {
      return [T1, T2];
    }

    int T1_size = towers[T1].removeLast();
    int T2_size = towers[T2].removeLast();

    if (T1_size < T2_size) {
      return [T1, T2];
    } else {
      return [T2, T1];
    }
  }

  for (int i = 0; i < math.pow(2, numDisks - 1); i++) {
    var move;
    move = legalMove(A, B);
    if (move == null) return null;
    moves.add(move);

    move = legalMove(B, C);
    if (move == null) return null; moves.add(move);

    move = legalMove(A, C);
    if (move == null) return null;
    moves.add(move);
  }

  return moves;
}

Future<List<List<int>>> getMovesRecursive(int numDisks) {
  ReceivePort receivePort = new ReceivePort();

  Completer completer = new Completer();

  receivePort.listen((var message) {
    if (message is List<List<int>>) {
      completer.complete(message);
    }
  });

  Isolate.spawn(solve, [receivePort.sendPort, numDisks]);

  return completer.future;
}
      
void solve(List<Object> args) {
  SendPort sendPort = args[0];
  int numToMove = args[1];

  List<List<int>> moves = new List<List<int>>();
  move(0, 1, 2, numToMove, moves);
  sendPort.send(moves);
}

void move(int A, int B, int C, int numToMove, List<List<int>> moves) {
  if (numToMove == 1) {
    moves.add([A, C]);
  } else {
    move(A, C, B, numToMove - 1, moves);
    move(A, B, C, 1, moves);
    move(B, A, C, numToMove - 1, moves);
  }
}