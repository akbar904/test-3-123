
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_dog_app/screens/home_screen.dart';
import 'package:cat_dog_app/cubits/animal_cubit.dart';
import 'package:cat_dog_app/widgets/animal_text_widget.dart';

// Mock Cubit
class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat with clock icon initially', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState('Cat', Icons.access_time));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon after tap', (WidgetTester tester) async {
			whenListen(
				animalCubit,
				Stream.fromIterable([
					AnimalState('Cat', Icons.access_time),
					AnimalState('Dog', Icons.person),
				]),
				initialState: AnimalState('Cat', Icons.access_time),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
