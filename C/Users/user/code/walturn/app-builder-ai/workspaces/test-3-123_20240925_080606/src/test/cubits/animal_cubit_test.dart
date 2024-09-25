
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:cat_dog_app/cubits/animal_cubit.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is AnimalState(name: "Cat", icon: Icons.access_time)', () {
			expect(animalCubit.state, AnimalState(name: 'Cat', icon: Icons.access_time));
		});

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState(name: "Dog", icon: Icons.person)] when toggleAnimal is called on initial state',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [AnimalState(name: 'Dog', icon: Icons.person)],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState(name: "Cat", icon: Icons.access_time)] when toggleAnimal is called on Dog state',
			build: () => animalCubit,
			seed: () => AnimalState(name: 'Dog', icon: Icons.person),
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [AnimalState(name: 'Cat', icon: Icons.access_time)],
		);
	});
}
