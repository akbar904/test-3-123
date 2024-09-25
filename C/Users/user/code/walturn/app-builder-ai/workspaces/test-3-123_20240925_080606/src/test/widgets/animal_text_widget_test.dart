
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cat_dog_app/widgets/animal_text_widget.dart';

void main() {
	group('AnimalTextWidget', () {
		testWidgets('displays Cat with clock icon initially', (WidgetTester tester) async {
			// Arrange
			const animalName = 'Cat';
			const animalIcon = Icons.access_time;

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: AnimalTextWidget(name: animalName, icon: animalIcon),
					),
				),
			);

			// Assert
			expect(find.text(animalName), findsOneWidget);
			expect(find.byIcon(animalIcon), findsOneWidget);
		});

		testWidgets('displays Dog with person icon when toggled', (WidgetTester tester) async {
			// Arrange
			const initialAnimalName = 'Cat';
			const initialAnimalIcon = Icons.access_time;
			const toggledAnimalName = 'Dog';
			const toggledAnimalIcon = Icons.person;

			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: AnimalTextWidget(name: initialAnimalName, icon: initialAnimalIcon),
					),
				),
			);

			// Act
			await tester.tap(find.text(initialAnimalName));
			await tester.pump();

			// Assert
			expect(find.text(toggledAnimalName), findsOneWidget);
			expect(find.byIcon(toggledAnimalIcon), findsOneWidget);
		});
	});
}
