import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/location_item_model.dart';

part 'loaction_state.dart';

class LoactionCubit extends Cubit<LoactionState> {
  LoactionCubit() : super(LoactionInitial());
  late String chosenLocationId;

  void fetchLocations() {
    emit(LoactionLoading());
    Future.delayed(const Duration(seconds: 1), () {
      emit(LoactionsLoaded(locations: dummyLocations));
      final chosenLocation = dummyLocations.firstWhere(
        (location) => location.isChosen == true,
        orElse: () => dummyLocations.first,
      );
      chosenLocationId = chosenLocation.id;
      emit(ChosenLocation(id: chosenLocationId));
    });
  }

  void addLocation(String location) {
    emit(LocationAdding());
    final List<String> locationSpliited = location.split(",");
    final newLocation = LocationItemModel(
      id: DateTime.now().toIso8601String(),
      city: locationSpliited[0],
      country: locationSpliited[1],
    );
    dummyLocations.add(newLocation);

    Future.delayed(const Duration(seconds: 1), () {
      emit(LoactionAdded());
      fetchLocations();
    });
  }

  void chosenLocation(String id) {
    chosenLocationId = id;
    emit(ChosenLocation(id: chosenLocationId));
  }

  void confirmLocation() {
    emit(ConfirmLocationLoading());

    final previoisIsChosenLocation = dummyLocations.firstWhere(
      (location) => location.isChosen == true,
      orElse: () => dummyLocations.first,
    );

    final previoisIsChosenIndex = dummyLocations.indexOf(
      previoisIsChosenLocation,
    );
    dummyLocations[previoisIsChosenIndex] = previoisIsChosenLocation.copyWith(
      isChosen: false,
    );

    final chosenLocation = dummyLocations.firstWhere(
      (location) => location.id == chosenLocationId,
      orElse: () => dummyLocations.first,
    );

    final chosenIndex = dummyLocations.indexOf(chosenLocation);
    dummyLocations[chosenIndex] = chosenLocation.copyWith(isChosen: true);

    Future.delayed(const Duration(seconds: 1), () {
      emit(ConfirmLocationSuccess(location: chosenLocation));
    });
  }
}
