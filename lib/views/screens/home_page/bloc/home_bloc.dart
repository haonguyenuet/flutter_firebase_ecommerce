import 'package:e_commerce_app/business_logic/repositories/home_repo.dart';
import 'package:e_commerce_app/views/screens/home_page/bloc/home_event.dart';
import 'package:e_commerce_app/views/screens/home_page/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;

  HomeBloc({@required HomeRepository homeRepository})
      : assert(homeRepository != null),
        _homeRepository = homeRepository,
        super(HomeLoading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadHome) {
      yield* _mapLoadHomeToState();
    } else if (event is RefreshHome) {
      yield HomeLoading();
      yield* _mapLoadHomeToState();
    }
  }

  Stream<HomeState> _mapLoadHomeToState() async* {
    try {
      final homeResponse = await _homeRepository.getHomeData();
      yield HomeLoaded(homeResponse: homeResponse);
    } catch (e) {
      yield HomeNotLoaded(e);
    }
  }
}
