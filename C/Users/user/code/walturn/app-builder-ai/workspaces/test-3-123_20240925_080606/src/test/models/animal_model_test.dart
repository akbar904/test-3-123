
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cat_dog_app/models/animal_model.dart';

void main() {
	group('Animal Model', () {
		test('Animal class should have name and icon properties', () {
			final animal = Animal(name: 'Cat', icon: Icons.pets);
			expect(animal.name, 'Cat');
			expect(animal.icon, Icons.pets);
		});

		test('Animal class should support equality', () {
			final animal1 = Animal(name: 'Cat', icon: Icons.pets);
			final animal2 = Animal(name: 'Cat', icon: Icons.pets);
			final animal3 = Animal(name: 'Dog', icon: Icons.person);

			expect(animal1, equals(animal2));
			expect(animal1, isNot(equals(animal3)));
		});

		test('Animal class should support hashCode', () {
			final animal1 = Animal(name: 'Cat', icon: Icons.pets);
			final animal2 = Animal(name: 'Cat', icon: Icons.pets);
			final animal3 = Animal(name: 'Dog', icon: Icons.person);

			expect(animal1.hashCode, equals(animal2.hashCode));
			expect(animal1.hashCode, isNot(equals(animal3.hashCode)));
		});
	});
}
