import 'package:flutter/material.dart';

typedef SliverBox = SliverToBoxAdapter;

typedef ValueCallback<T> = void Function(T);

typedef LinkCallback = ValueCallback<String>;

T identity<T>(T value) => value;
