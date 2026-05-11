import 'package:flutter/material.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}


class ProfileLoading extends ProfileState {}
class ProfileSuccess extends ProfileState {
  final Map<String, dynamic> userData;
  ProfileSuccess({required this.userData});
}
class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class LogoutLoading extends ProfileState {}
class LogoutSuccess extends ProfileState {}
class LogoutError extends ProfileState {
  final String error;
  LogoutError(this.error);
}