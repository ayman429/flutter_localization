part of 'localization_cubit.dart';

@immutable
sealed class LocalizationState {}

final class LocalizationInitial extends LocalizationState {}

final class LocalizationEn extends LocalizationState {}

final class LocalizationAr extends LocalizationState {}

final class LocalizationValue extends LocalizationState {
  final String lang;
  LocalizationValue({required this.lang});
}
