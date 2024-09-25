
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cat_dog_app/main.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('MyApp', () {
		testWidgets('renders HomeScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});

	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		test('initial state is Cat with clock icon', () {
			when(() => animalCubit.state).thenReturn(AnimalState('Cat', Icons.access_time));
			expect(animalCubit.state, AnimalState('Cat', Icons.access_time));
		});

		blocTest<AnimalCubit, AnimalState>(
			'emits Dog with person icon when toggleAnimal is called',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [AnimalState('Dog', Icons.person)],
		);
	});

	group('HomeScreen', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		Widget createHomeScreen() {
			return MaterialApp(
				home: BlocProvider<AnimalCubit>(
					create: (_) => animalCubit,
					child: HomeScreen(),
				),
			);
		}

		testWidgets('displays initial Cat text with clock icon', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState('Cat', Icons.access_time));

			await tester.pumpWidget(createHomeScreen());

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('toggles to Dog text with person icon on tap', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState('Cat', Icons.access_time));
			whenListen(animalCubit, Stream.fromIterable([AnimalState('Dog', Icons.person)]));

			await tester.pumpWidget(createHomeScreen());
			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
