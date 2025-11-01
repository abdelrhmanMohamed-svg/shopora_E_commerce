import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/location_item_model.dart';

part 'loaction_state.dart';

class LoactionCubit extends Cubit<LoactionState> {
  LoactionCubit() : super(LoactionInitial());

  void fetchLocations() {
    emit(LoactionLoading());
    Future.delayed(const Duration(seconds: 1), () {
      emit(LoactionsLoaded(locations: dummyLocations));
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
}
