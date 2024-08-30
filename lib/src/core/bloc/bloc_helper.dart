import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

BlocProvider<T> createBlocProvider<T extends StateStreamableSource<Object?>>(
    T bloc,
    {bool lazy = false}) {
  return BlocProvider<T>(
    create: (_) => bloc,
    lazy: lazy,
  );
}

BlocProvider<T>
    createBlocProviderWithChild<T extends StateStreamableSource<Object?>>(
  T bloc, {
  required Widget child,
  Key? key,
  bool lazy = false,
}) {
  return BlocProvider<T>(
    create: (_) => bloc,
    key: key,
    lazy: lazy,
    child: child,
  );
}