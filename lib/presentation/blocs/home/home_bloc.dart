import 'package:daggerheart_beyond/domain/use_case/auth_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthUseCase _authUseCase;

  HomeBloc(this._authUseCase) : super(HomeInitial()) {
    on<LogOutPressed>((event, emit) async {
      try {
        emit(HomeLoading());
        await _authUseCase.logOut();
        emit(HomeLoggedOut());
      } catch (e) {
        emit(HomeError(e as Exception));
      }
    });
  }
}
