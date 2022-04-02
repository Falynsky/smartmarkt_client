import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/bloc/profile/profile_bloc.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class ProfileAvatar extends StatefulWidget {
  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [_circleAvatar(), SizedBox(height: 10), _profileName()],
      ),
    );
  }

  Widget _circleAvatar() {
    return CircleAvatar(
      backgroundColor: complementaryThree,
      radius: 65,
      child: Text(
        _profileBloc.initials,
        style: TextStyle(fontSize: 55),
      ),
    );
  }

  Widget _profileName() {
    return Text(
      _profileBloc.name,
      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _profileBloc.close();
  }
}
