// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/sample/model/counter_model.dart';
import 'package:flutter_module/sample/widget/home.dart';
import 'package:provider/provider.dart';

/// The entrypoint for the flutter module.
void main() {
  // This call ensures the Flutter binding has been set up before creating the
  // MethodChannel-based model.
  WidgetsFlutterBinding.ensureInitialized();

  final model = CounterModel();

  getError();

  runZoned(
    () => runApp(
      ChangeNotifierProvider.value(
        value: model,
        child: const MyApp(),
      ),
    ),
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line){
        developer.log("Interceptor $line");
      },
      handleUncaughtError: (self, parent, zone, error, stackTrace){
        developer.log("stackTrace $stackTrace");
      }
    )
  );
}

void getError() {
  FlutterError.onError = (details){
    FlutterError.dumpErrorToConsole(details);
    developer.log("stackTrace ${details.stack}");
    var rendererView = RendererBinding.instance?.renderView;
    debugDumpLayerTree();
    debugDumpRenderTree();
  };
}