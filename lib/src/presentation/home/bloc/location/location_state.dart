part of 'location_cubit.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.initial() = _Initial;
  const factory LocationState.inLocation() = _InLocation;
  const factory LocationState.outLocation() = _OutLocation;
  const factory LocationState.failed() = _Failed;
  const factory LocationState.loading() = _Loading;
}
