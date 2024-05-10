import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mvvm_playground/features/state/base_state.dart';
import 'package:mvvm_playground/functions/set_location.dart';

@injectable
class MapsCubit extends Cubit<BaseState> {
  MapsCubit() : super(BaseState());

  Future initLocation() async {
    emit(LoadingState());
    try {
      final pos = await determinePosition();
      emit(SuccessState<LatLng>(data: pos));
    } on Exception catch (e) {
      emit(GeneralErrorState(e: e));
    }
  }
}
