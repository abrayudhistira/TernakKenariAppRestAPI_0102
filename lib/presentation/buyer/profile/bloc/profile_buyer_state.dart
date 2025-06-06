part of 'profile_buyer_bloc.dart';

@immutable
sealed class ProfileBuyerState {}

final class ProfileBuyerInitial extends ProfileBuyerState {}

final class ProfileBuyerLoading extends ProfileBuyerState {}

final class ProfileBuyerLoaded extends ProfileBuyerState {
  final BuyerProfileResponseModel profile;

  ProfileBuyerLoaded(this.profile);
}

final class ProfileBuyerError extends ProfileBuyerState {
  final String message;

  ProfileBuyerError(this.message);
}

final class ProfileBuyerAdded extends ProfileBuyerState {
  final BuyerProfileResponseModel profile;

  ProfileBuyerAdded(this.profile);
}

final class ProfileBuyerAddError extends ProfileBuyerState {
  final String message;

  ProfileBuyerAddError(this.message);
}