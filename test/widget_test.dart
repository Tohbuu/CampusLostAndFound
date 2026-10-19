import 'package:campus_lost_found/app/found_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void setViewport(WidgetTester tester, Size size) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
}

void resetViewport(WidgetTester tester) {
  tester.view.resetPhysicalSize();
  tester.view.resetDevicePixelRatio();
}

void main() {
  testWidgets('starts on the FOUND. home screen', (tester) async {
    setViewport(tester, const Size(400, 800));
    addTearDown(() => resetViewport(tester));

    await tester.pumpWidget(const ProviderScope(child: FoundApp()));
    await tester.pumpAndSettle();

    expect(find.text('FOUND.'), findsOneWidget);
    expect(find.text('A little kindness,\na big difference.'), findsOneWidget);
    expect(find.text('Explore reports'), findsOneWidget);
    expect(find.text('Report an item'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('home action navigates to Discover', (tester) async {
    setViewport(tester, const Size(400, 800));
    addTearDown(() => resetViewport(tester));

    await tester.pumpWidget(const ProviderScope(child: FoundApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Explore reports'));
    await tester.pumpAndSettle();

    expect(find.text('Find items around campus'), findsOneWidget);
    expect(
      find.text(
        'Search and filter lost and found reports. '
        'Live reports will appear here after Firebase integration.',
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('compact navigation opens My Activity', (tester) async {
    setViewport(tester, const Size(400, 800));
    addTearDown(() => resetViewport(tester));

    await tester.pumpWidget(const ProviderScope(child: FoundApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('My Activity'));
    await tester.pumpAndSettle();

    expect(find.text('Your reports and claims'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('wide layout renders and navigates without overflow', (
    tester,
  ) async {
    setViewport(tester, const Size(1100, 800));
    addTearDown(() => resetViewport(tester));

    await tester.pumpWidget(const ProviderScope(child: FoundApp()));
    await tester.pumpAndSettle();

    expect(find.text('FOUND.'), findsNWidgets(2));
    expect(find.text('Explore reports'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('My Activity').first);
    await tester.pumpAndSettle();

    expect(find.text('Your reports and claims'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
