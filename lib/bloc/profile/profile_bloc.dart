import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/profile/profile_event.dart';
import 'package:smartmarktclient/bloc/profile/profile_state.dart';
import 'package:smartmarktclient/repositories/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository _profileRepository;

  ProfileBloc() : super(InitialProfileState()) {
    _profileRepository = ProfileRepository();
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {}
}
