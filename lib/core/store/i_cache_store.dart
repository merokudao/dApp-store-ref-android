import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

abstract class ICacheStore {
  initialise();
  HiveCacheStore get cacheStore;
  Iterable<DioCacheInterceptor> get dioCacheInterceptor;
}
