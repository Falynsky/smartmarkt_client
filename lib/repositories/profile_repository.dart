import 'package:smartmarktclient/providers/profile_provider.dart';

class ProfileRepository {
  ProfileProvider _profileProvider;

  ProfileRepository() {
    _profileProvider = ProfileProvider();
  }
}
