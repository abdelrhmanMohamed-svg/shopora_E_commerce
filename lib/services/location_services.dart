import 'package:shopora_e_commerce/model/location_item_model.dart';
import 'package:shopora_e_commerce/services/firestore_services.dart';
import 'package:shopora_e_commerce/utils/api_paths.dart';

abstract class LocationServices {
  Future<void> setLocation(String userId, LocationItemModel location);
  Future<List<LocationItemModel>> fetchLocations(String userId);
  Future<LocationItemModel> fetchLocation(String userId, String locationId);
}

class LocationServicesImpl implements LocationServices {
  final _fireStoreServices = FirestoreServices.instance;

  @override
  Future<void> setLocation(String userId, LocationItemModel location) =>
      _fireStoreServices.setData(
        path: ApiPaths.location(userId, location.id),
        data: location.toMap(),
      );

  @override
  Future<LocationItemModel> fetchLocation(String userId, String locationId) =>
      _fireStoreServices.getDocument(
        path: ApiPaths.location(userId, locationId),
        builder: (data, documentID) => LocationItemModel.fromMap(data),
      );

  @override
  Future<List<LocationItemModel>> fetchLocations(
    String userId, [
    bool isChosen = false,
  ]) => _fireStoreServices.getCollection(
    path: ApiPaths.locations(userId),
    builder: (data, documentId) => LocationItemModel.fromMap(data),
    queryBuilder: isChosen
        ? (query) => query.where('isChosen', isEqualTo: true)
        : null,
  );
}
