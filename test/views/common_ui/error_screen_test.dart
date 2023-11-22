import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_funda/views/common_ui/error_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockVoidCallback extends Mock {
  void call();
}

void main() {
  group('ErrorScreen', () {
    late MockVoidCallback onTryAgain;

    setUp(() {
      onTryAgain = MockVoidCallback();
    });

    Widget createSut([Widget? errorScreen]) => MaterialApp(
          home: Scaffold(
            body: errorScreen ??
                ErrorScreen(
                  onTryAgain: onTryAgain,
                ),
          ),
        );

    testWidgets(
        'when rendering the Error screen with the default constructor'
        'then should render correctly with default message', (tester) async {
      await tester.pumpWidget(createSut());

      expect(find.text('Try Again'), findsOneWidget);
    });

    testWidgets(
        'when rendering the Error screen with the houseCouldBeSold constructor'
        'then should render correctly with custom message', (tester) async {
      const errorMessage =
          'Something went wrong please try again \n the house could be sold!';

      await tester
          .pumpWidget(createSut(ErrorScreen.houseCouldBeSold(onTryAgain)));

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets(
        'when tapping the try again button'
        'then should call onTryAgain when try again button is tapped',
        (tester) async {
      await tester.pumpWidget(createSut());

      await tester.tap(find.text('Try Again'));

      verify(onTryAgain).called(1);
    });
  });
}
