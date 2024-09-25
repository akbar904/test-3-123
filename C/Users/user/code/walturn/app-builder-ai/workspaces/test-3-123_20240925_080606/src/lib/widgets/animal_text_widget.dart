
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/animal_cubit.dart';
import '../models/animal_model.dart';

class AnimalTextWidget extends StatelessWidget {
	final String name;
	final IconData icon;

	const AnimalTextWidget({Key? key, required this.name, required this.icon}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return BlocBuilder<AnimalCubit, AnimalState>(
			builder: (context, state) {
				return GestureDetector(
					onTap: () {
						context.read<AnimalCubit>().toggleAnimal();
					},
					child: Row(
						children: [
							Text(state.name),
							Icon(state.icon),
						],
					),
				);
			},
		);
	}
}
