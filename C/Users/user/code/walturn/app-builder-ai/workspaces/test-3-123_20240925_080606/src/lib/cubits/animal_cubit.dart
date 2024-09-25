
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:cat_dog_app/models/animal_model.dart';

class AnimalState {
	final String name;
	final IconData icon;

	AnimalState({required this.name, required this.icon});
}

class AnimalCubit extends Cubit<AnimalState> {
	AnimalCubit() : super(AnimalState(name: 'Cat', icon: Icons.access_time));

	void toggleAnimal() {
		if (state.name == 'Cat') {
			emit(AnimalState(name: 'Dog', icon: Icons.person));
		} else {
			emit(AnimalState(name: 'Cat', icon: Icons.access_time));
		}
	}
}
