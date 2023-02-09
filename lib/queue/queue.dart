import 'package:queue/queue.dart';

final queues = <String, Queue>{};

Queue initQueue(String key) {
  if (queues[key] != null) {
    return queues[key]!;
  }
  queues[key] = Queue(delay: const Duration(milliseconds: 100), parallel: 3);
  return queues[key]!;
}
