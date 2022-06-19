import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sampleflutter/pages/homePage/homePage.dart';
import 'package:sampleflutter/main.dart' as app;
import 'package:sampleflutter/pages/homePage/widgets/customTextField.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  List<int> currentWillSearchList = [
    3,
    4,
    6,
    9,
    10,
    12,
    14,
    15,
    17,
    19,
    21,
    25,
    29,
    32,
    35,
    39,
    45,
    49,
    55,
    57,
    59,
    62,
    65,
    68
  ];

  testWidgets("is containing number give less lowest number", (WidgetTester widgetTester) async {
    app.main();

    await widgetTester.pumpWidget(HomePage(
      key: const ValueKey("HomePage"),
      currentWillSearchList: currentWillSearchList,
    ));
    //It runs in log time O(log n). So if we have an array of 1024 elements, the maximum number of steps is log21024 = 10 because 210 = 1024
    int maximumStepOfCurrentList = log(currentWillSearchList.length).floor();
    await widgetTester.pumpAndSettle(const Duration(seconds: 2));

    await widgetTester.enterText(find.byKey(const ValueKey(HomePageKeys.generalTextField)), "13");
    await widgetTester.tap(find.byKey(const ValueKey(HomePageKeys.startSearchButtonKey)));
    await widgetTester.pumpAndSettle(Duration(seconds: maximumStepOfCurrentList));

    expect(find.textContaining("Final result founded : 12"), findsOneWidget);
  });

  testWidgets("is exact number is give same number", (WidgetTester widgetTester) async {
    app.main();
    await widgetTester.pumpWidget(HomePage(
      key: const ValueKey("HomePage"),
      currentWillSearchList: currentWillSearchList,
    ));
    int maximumStepOfCurrentList = log(currentWillSearchList.length).floor();

    await widgetTester.pumpAndSettle(const Duration(seconds: 2));
    await widgetTester.enterText(find.byKey(const ValueKey(HomePageKeys.generalTextField)), "45");
    await widgetTester.tap(find.byKey(const ValueKey(HomePageKeys.startSearchButtonKey)));
    await widgetTester.pumpAndSettle(Duration(seconds: maximumStepOfCurrentList));

    expect(find.textContaining("Final result founded : 45"), findsOneWidget);
  });

  testWidgets("is lower than lowest variable gives -1", (WidgetTester widgetTester) async {
    app.main();
    await widgetTester.pumpWidget(HomePage(
      key: const ValueKey("HomePage"),
      currentWillSearchList: currentWillSearchList,
    ));

    int maximumStepOfCurrentList = log(currentWillSearchList.length).floor();
    int lowerThanLowestNumber = currentWillSearchList.first - 1;

    await widgetTester.pumpAndSettle(const Duration(seconds: 2));
    await widgetTester.enterText(
        find.byKey(const ValueKey(HomePageKeys.generalTextField)), lowerThanLowestNumber.toString());
    await widgetTester.tap(find.byKey(const ValueKey(HomePageKeys.startSearchButtonKey)));
    await widgetTester.pumpAndSettle(Duration(seconds: maximumStepOfCurrentList));

    expect(find.textContaining("Final result founded : -1"), findsOneWidget);
  });

  testWidgets("is higher than last array member will give last array member", (WidgetTester widgetTester) async {
    app.main();
    await widgetTester.pumpWidget(HomePage(
      key: const ValueKey("HomePage"),
      currentWillSearchList: currentWillSearchList,
    ));
    int maximumStepOfCurrentList = log(currentWillSearchList.length).floor();
    int higherThanHighestNumber = currentWillSearchList.last + 1;

    await widgetTester.pumpAndSettle(const Duration(seconds: 2));
    await widgetTester.enterText(
        find.byKey(const ValueKey(HomePageKeys.generalTextField)), higherThanHighestNumber.toString());
    await widgetTester.tap(find.byKey(const ValueKey(HomePageKeys.startSearchButtonKey)));
    await widgetTester.pumpAndSettle(Duration(seconds: maximumStepOfCurrentList));

    expect(find.textContaining("Final result founded : 68"), findsOneWidget);
  });
}
