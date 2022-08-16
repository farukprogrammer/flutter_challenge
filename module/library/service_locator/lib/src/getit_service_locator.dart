import 'dart:async';

import 'package:get_it/get_it.dart' as get_it;

import 'registrar.dart';
import 'service_locator.dart';

class GetItServiceLocator implements ServiceLocator {

  final _getIt = get_it.GetIt.asNewInstance();

  @override
  Function(bool pushed)? get onScopeChanged {
    return _getIt.onScopeChanged;
  }

  @override
  set onScopeChanged(Function(bool pushed)? lambda) {
    _getIt.onScopeChanged = lambda;
  }

  @override
  Future<void> allReady({Duration? timeout, bool ignorePendingAsyncCreation = false}) {
    return _getIt.allReady(timeout: timeout, ignorePendingAsyncCreation: ignorePendingAsyncCreation);
  }

  @override
  bool allReadySync([bool ignorePendingAsyncCreation = false]) {
    return _getIt.allReadySync(ignorePendingAsyncCreation);
  }

  @override
  T call<T extends Object>({String? instanceName, param1, param2}) {
    return _getIt.call<T>(instanceName: instanceName, param1: param1, param2: param2);
  }

  @override
  String? get currentScopeName => _getIt.currentScopeName;

  @override
  T get<T extends Object>({String? instanceName, param1, param2}) {
    return _getIt.get<T>(instanceName:instanceName, param1: param1, param2: param2);
  }

  @override
  Future<T> getAsync<T extends Object>({String? instanceName, param1, param2}) {
    return _getIt.getAsync<T>(instanceName:instanceName, param1: param1, param2: param2);
  }

  @override
  Future<void> isReady<T extends Object>({Object? instance, String? instanceName, Duration? timeout, Object? callee}) {
    return _getIt.isReady<T>(instance:instance, instanceName: instanceName, timeout: timeout, callee: callee);
  }

  @override
  bool isReadySync<T extends Object>({Object? instance, String? instanceName}) {
    return _getIt.isReadySync<T>(instance: instance, instanceName: instanceName);
  }

  @override
  bool isRegistered<T extends Object>({Object? instance, String? instanceName}) {
    return _getIt.isRegistered<T>(instance: instance, instanceName: instanceName);
  }

  @override
  Future<void> popScope() {
    return _getIt.popScope();
  }

  @override
  Future<bool> popScopesTill(String name) {
    return _getIt.popScopesTill(name);
  }

  @override
  void pushNewScope({void Function(ServiceLocator locator)? init, String? scopeName, ScopeDisposeFunc? dispose}) {
    return _getIt.pushNewScope(init: (getit) {
      init?.call(getit as ServiceLocator);
    }, scopeName: scopeName, dispose: dispose);
  }

  @override
  void registerFactory<T extends Object>(Factory<T> factoryFunc, {String? instanceName}) {
    return _getIt.registerFactory<T>(factoryFunc, instanceName: instanceName);
  }

  @override
  void registerFactoryAsync<T extends Object>(FactoryAsync<T> factoryFunc, {String? instanceName}) {
    return _getIt.registerFactoryAsync<T>(factoryFunc, instanceName: instanceName);
  }

  @override
  void registerFactoryParam<T extends Object, P1, P2>(FactoryParam<T, P1, P2> factoryFunc, {String? instanceName}) {
    return _getIt.registerFactoryParam<T, P1, P2>(factoryFunc, instanceName: instanceName);
  }

  @override
  void registerFactoryParamAsync<T extends Object, P1, P2>(FactoryFuncParamAsync<T, P1?, P2?> factoryFunc, {String? instanceName}) {
    return _getIt.registerFactoryParamAsync<T, P1, P2>(factoryFunc, instanceName: instanceName);
  }

  @override
  void registerLazySingleton<T extends Object>(Factory<T> factoryFunc, {String? instanceName, DisposingFunc<T>? dispose}) {
    return _getIt.registerLazySingleton<T>(factoryFunc, instanceName: instanceName, dispose: dispose);
  }

  @override
  void registerLazySingletonAsync<T extends Object>(FactoryAsync<T> factoryFunc, {String? instanceName, DisposingFunc<T>? dispose}) {
    return _getIt.registerLazySingletonAsync<T>(factoryFunc, instanceName: instanceName, dispose: dispose);
  }

  @override
  void registerSingleton<T extends Object>(T instance, {String? instanceName, bool? signalsReady, DisposingFunc<T>? dispose}) {
    return _getIt.registerSingleton<T>(instance, instanceName: instanceName, signalsReady: signalsReady, dispose: dispose);
  }

  @override
  void registerSingletonAsync<T extends Object>(FactoryAsync<T> factoryFunc, {String? instanceName, Iterable<Type>? dependsOn, bool? signalsReady, DisposingFunc<T>? dispose}) {
    return _getIt.registerSingletonAsync<T>(factoryFunc, instanceName: instanceName, dependsOn: dependsOn, signalsReady: signalsReady, dispose: dispose);
  }

  @override
  void registerSingletonWithDependencies<T extends Object>(Factory<T> factoryFunc, {String? instanceName, Iterable<Type>? dependsOn, bool? signalsReady, DisposingFunc<T>? dispose}) {
    return _getIt.registerSingletonWithDependencies<T>(factoryFunc, instanceName:instanceName, dependsOn: dependsOn, signalsReady: signalsReady, dispose: dispose);
  }

  @override
  Future<void> reset({bool dispose = true}) {
    return _getIt.reset(dispose: dispose);
  }

  @override
  FutureOr resetLazySingleton<T extends Object>({Object? instance, String? instanceName, FutureOr Function(T p1)? disposingFunction}) {
    return _getIt.resetLazySingleton<T>(instance: instance, instanceName: instanceName, disposingFunction: disposingFunction);
  }

  @override
  Future<void> resetScope({bool dispose = true}) {
    return _getIt.resetScope(dispose: dispose);
  }

  @override
  void signalReady(Object? instance) {
    _getIt.signalReady(instance);
  }

  @override
  FutureOr unregister<T extends Object>({Object? instance, String? instanceName, FutureOr Function(T p1)? disposingFunction}) {
    return _getIt.unregister<T>(instance: instance, instanceName: instanceName, disposingFunction: disposingFunction);
  }

  Set<Type> alreadyRegistered = {};

  @override
  Future<void> registerRegistrar(Registrar registrar) async {
    if (alreadyRegistered.add(registrar.runtimeType)) {
      await registrar.register(this);
    }
  }
}