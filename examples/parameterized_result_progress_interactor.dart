import 'dart:async';

import 'package:use_in_case/use_in_case.dart';

typedef SourceUrl = String;
typedef DestinationFilepath = String;
typedef Parameter = ({
  SourceUrl sourceUrl,
  DestinationFilepath destinationFilepath
});

typedef DownloadedBytes = int;
typedef DownloadProgress = int;

final class ProgressCounter extends ParameterizedResultProgressInteractor<
    Parameter, DownloadedBytes, DownloadProgress> {
  @override
  Future<DownloadedBytes> execute(Parameter input) async {
    // TODO: Implement your file download here

    final totalBytes = 1000;

    for (var i = 0; i < totalBytes; i++) {
      await Future.delayed(const Duration(milliseconds: 1));
      final progress = (i / totalBytes * 100).toInt();
      await emitProgress(progress);
    }

    return totalBytes;
  }
}

void main() async {
  final interactor = ProgressCounter();
  final stopwatch = Stopwatch();

  final result = await interactor
      .receiveProgress((progress) async {
        print('Download-Progress: $progress%');
      })
      .before((_) async => stopwatch.start())
      .eventually(() async {
        final duration = (stopwatch..stop()).elapsed;
        print('The download took: ${duration.inSeconds}s');
      })
      .timeout(const Duration(seconds: 2), errorMessage: 'Download timed out')
      .typedRecover<TimeoutException>((error) async {
        return 0;
      })
      .getOrThrow((
        sourceUrl: 'https://example.com/image.jpg',
        destinationFilepath: 'image.jpg'
      ));

  print(result); // 1000
}
