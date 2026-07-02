import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

/// Shared HTTP client for downloads, uploads with progress, and byte fetches.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final client = Dio();
  ref.onDispose(() => client.close(force: true));
  return client;
}
