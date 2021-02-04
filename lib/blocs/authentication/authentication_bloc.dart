// import 'dart:async';

// import 'package:e_commerce_app/models/user.dart';
// import 'package:e_commerce_app/services/authentication_service.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'authentication_event.dart';
// import 'authentication_state.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final AuthenticationService _authenticationRepository;
//   StreamSubscription<User> _userSubscription;

//   // AuthenticationBloc Constructor
//   AuthenticationBloc({@required AuthenticationService authenticationRepository})
//       : assert(AuthenticationService != null),
//         _authenticationRepository = authenticationRepository,
//         super(AuthenticationState.unknown()) {
//     // Each time authentication state changes add event
//     _userSubscription = _authenticationRepository.user
//         .listen((user) => add(AuthenticationUserChanged(user)));
//   }

//   @override
//   Stream<AuthenticationState> mapEventToState(
//       AuthenticationEvent event) async* {
//     if (event is AuthenticationUserChanged) {
//       yield _mapUserChangedEventToState(event);
//     } else if (event is AuthenticationLoggedOutRequest) {
//       await (_authenticationRepository.logOut());
//     }
//   }

//   AuthenticationState _mapUserChangedEventToState(
//       AuthenticationUserChanged event) {
//     return event.user == User.empty
//         ? AuthenticationState.unauthenticated()
//         : AuthenticationState.authenticated(event.user);
//   }

//   @override
//   Future<void> close() {
//     _userSubscription?.cancel();
//     return super.close();
//   }
// }
