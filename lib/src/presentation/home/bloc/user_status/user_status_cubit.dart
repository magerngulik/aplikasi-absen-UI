// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:new_attandance/src/presentation/home/data/attandance_services.dart';

part 'user_status_cubit.freezed.dart';
part 'user_status_state.dart';

class UserStatusCubit extends Cubit<UserStatusState> {
  Dio dio;
  UserStatusCubit({required this.dio}) : super(const UserStatusState.initial());

  cekData() async {
    emit(const UserStatusState.loading());
    var services = AttandanceService(dioServices: dio);

    var data = await services.getCurrent();
    data.fold((l) {
      emit(UserStatusState.failed(errorMessage: l));
    }, (r) {
      var data = r['data'];
      if (data == null) {
        emit(const UserStatusState.signIn());
      } else {
        var waktuKeluar = data['waktu_keluar'];
        if (waktuKeluar == null) {
          emit(UserStatusState.signOut(data: data));
        } else {
          emit(UserStatusState.complate(data: data));
        }
      }
    });
  }
}
