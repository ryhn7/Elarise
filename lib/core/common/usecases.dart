abstract interface class UseCases<R, P> {
  Future<R> call(P params);
}