import 'dart:async';
import 'dart:ffi';  // For FFI
import 'dart:io';   // For Platform.isX

import 'package:flutter/services.dart';

final DynamicLibrary nativeAddLib =
  Platform.isAndroid
    ? DynamicLibrary.open("hello")
    : DynamicLibrary.process();

final int Function(int x, int y) nativeAdd =
  nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();

class Hello {
  static const MethodChannel _channel =
      const MethodChannel('hello');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
