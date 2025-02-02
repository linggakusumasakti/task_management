import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

class GlobalBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('${bloc.runtimeType} $event', name: 'On Event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('${bloc.runtimeType} $change', name: 'On Change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('${bloc.runtimeType} $transition', name: 'On Transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('${bloc.runtimeType} $error $stackTrace', name: 'On Error');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('${bloc.runtimeType}', name: 'On Close');
  }
}
