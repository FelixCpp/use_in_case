import 'dart:async';

import 'package:uic_common/uic_common.dart';

abstract interface class BusyStateListener {
  OwnedStreamSubscription<bool> listen(
    void Function(bool) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  });

  void addLoader();
  void removeLoader();
  Future<void> release();
}
