import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/location_item_model.dart';
import 'package:shopora_e_commerce/services/auth_service.dart';
import 'package:shopora_e_commerce/services/location_services.dart';

part 'loaction_state.dart';

class LoactionCubit extends Cubit<LoactionState> {
  LoactionCubit() : super(LoactionInitial());
  late String chosenLocationId;
  final _locationServices = LocationServicesImpl();
  final _authServices = AuthServiceImpl();

  Future<void> fetchLocations() async {
    emit(LoactionLoading());
    try {
      final currentUser = _authServices.getCuurentUser();
      final locations = await _locationServices.fetchLocations(
        currentUser!.uid,
      );
      if(locations.isNotEmpty){
         emit(LoactionsLoaded(locations: locations));
      final chosenLocations = await _locationServices.fetchLocations(
        currentUser.uid,
        true,
      );
      if (chosenLocations.isNotEmpty) {
        chosenLocationId = chosenLocations.first.id;
      } else {
        chosenLocationId = locations.first.id;
      }
      emit(ChosenLocation(id: chosenLocationId));
      }else{
        emit(LoactionError("No locations found"));
      }
     
    } catch (e) {
      emit(LoactionError(e.toString()));
    }
    // Future.delayed(const Duration(seconds: 1), () {
    //   emit(LoactionsLoaded(locations: dummyLocations));
    //   final chosenLocation = dummyLocations.firstWhere(
    //     (location) => location.isChosen == true,
    //     orElse: () => dummyLocations.first,
    //   );
    //   chosenLocationId = chosenLocation.id;
    //   emit(ChosenLocation(id: chosenLocationId));
    // });
  }

  Future<void> addLocation(String location) async {
    emit(LocationAdding());
    try {
      final currentUser = _authServices.getCuurentUser();
      final List<String> locationSpliited = location.split(",");
      final newLocation = LocationItemModel(
        id: DateTime.now().toIso8601String(),
        city: locationSpliited[0],
        country: locationSpliited[1],
      );
      await _locationServices.setLocation(currentUser!.uid, newLocation);
      emit(LoactionAdded());
      fetchLocations();
    } catch (e) {
      emit(LocationErrorAdding(e.toString()));
    }
  }

  void chosenLocation(String id) {
    chosenLocationId = id;
    emit(ChosenLocation(id: chosenLocationId));
  }

  Future<void> confirmLocation() async {
    emit(ConfirmLocationLoading());
    try {
      final currentUser = _authServices.getCuurentUser();
      final chosenPrevoiusLocations = await _locationServices.fetchLocations(
        currentUser!.uid,
        true,
      );
      if (chosenPrevoiusLocations.isNotEmpty) {
        var prevoiusChosenLocation = chosenPrevoiusLocations.first;
        prevoiusChosenLocation = prevoiusChosenLocation.copyWith(
          isChosen: false,
        );
        await _locationServices.setLocation(
          currentUser.uid,
          prevoiusChosenLocation,
        );
      }
      var chosenLocation = await _locationServices.fetchLocation(
        currentUser.uid,
        chosenLocationId,
      );
      chosenLocation = chosenLocation.copyWith(isChosen: true);
      await _locationServices.setLocation(currentUser.uid, chosenLocation);
      emit(ConfirmLocationSuccess(location: chosenLocation));
    } catch (e) {
      emit(ConfirmLocationError(e.toString()));
    }

    // final previoisIsChosenLocation = dummyLocations.firstWhere(
    //   (location) => location.isChosen == true,
    //   orElse: () => dummyLocations.first,
    // );

    // final previoisIsChosenIndex = dummyLocations.indexOf(
    //   previoisIsChosenLocation,
    // );
    // dummyLocations[previoisIsChosenIndex] = previoisIsChosenLocation.copyWith(
    //   isChosen: false,
    // );

    // final chosenLocation = dummyLocations.firstWhere(
    //   (location) => location.id == chosenLocationId,
    //   orElse: () => dummyLocations.first,
    // );

    // final chosenIndex = dummyLocations.indexOf(chosenLocation);
    // dummyLocations[chosenIndex] = chosenLocation.copyWith(isChosen: true);

    // Future.delayed(const Duration(seconds: 1), () {
    //   emit(ConfirmLocationSuccess(location: chosenLocation));
    // });
  }
}
