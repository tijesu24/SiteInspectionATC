import 'dart:async';

class OnlineQueue {
  StreamController<List<dynamic>> queue;
  final List<String> events = ['new', 'update', 'delete'];

  OnlineQueue() {
    queue.stream.listen((data) {
      print(data);
    });
  }

  addToQueue(List<dynamic> update) {
    queue.add(update);
  }
}
