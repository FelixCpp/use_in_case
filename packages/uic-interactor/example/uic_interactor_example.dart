import 'dart:io';

import 'package:uic_interactor/uic_interactor.dart';

class DivideByTwoInteractor extends ParameterizedResultInteractor<int, int> {
  const DivideByTwoInteractor();

  @override
  Future<int> execute(int input) async {
    return input ~/ 2;
  }
}

class SaveToFileInteractor extends ParameterizedResultInteractor<String, void> {
  const SaveToFileInteractor();

  @override
  Future<void> execute(String content) async {
    final file = File('example_file.txt');
    await file.writeAsString(content);
  }
}

Future<void> main() async {
  const value = 502;

  const divideByTwo = DivideByTwoInteractor();
  final result = await divideByTwo(value).getOrElse(fallback: -1);

  print(result);

  const saveToFile = SaveToFileInteractor();
  saveToFile("$value ~/ 2 = $result").configure(
    onSuccess: (_) {
      print('Content has been saved successfully.');
    },
    onFailure: (exception) {
      print('Could not save content to file. Exception: $exception');
    },
    run: true,
  );
}
