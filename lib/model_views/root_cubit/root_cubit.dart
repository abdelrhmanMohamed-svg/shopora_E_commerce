import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/user_data_model.dart';
import 'package:shopora_e_commerce/services/auth_service.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit() : super(RootInitial());
  final _authServices = AuthServiceImpl();

  void updateSelectedIndex(int index) {
    emit(UpdateSelcetedIndex(index: index));
  }

  
}
