import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/blocs/user/user_bloc.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/config/themes/card_decoration.dart';
import 'package:mycompany/src/presentation/screens/edit_profile.dart';
import 'package:mycompany/src/presentation/screens/login.dart';
import 'package:mycompany/src/presentation/shared/utils/color_extension.dart';
import 'package:mycompany/src/presentation/widgets/custom_title.dart';
import 'package:mycompany/src/presentation/widgets/header_label.dart';
import 'package:mycompany/src/presentation/widgets/tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserBloc _userBloc = UserBloc();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userToken");
    if (userId != null) {
      _userBloc.add(GetUser(userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: _userBloc,
      builder: (context, state) {
        if (state is UserLoaded) {
          return _buildPage(state);
        } else if (state is UserError) {
          return Center(child: Text(state.error));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildPage(state) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitle(label: "${state.user.firstName} ${state.user.lastName}"),
            const SizedBox(
              height: 15,
            ),
            const HeaderLabel(label: "Information"),
            _buildInformation(state),
            const SizedBox(
              height: 20,
            ),
            _buildPersonalInfomartionHeader(state),
            _buildPersonalInformation(state),
            const Spacer(),
            _buildLogOutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInformation(UserLoaded state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: CardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Activity area",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: state.user.poles.map((pole) {
              return Tile(
                color: getColor(pole.color),
                label: pole.name,
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Projects",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: state.user.projects.map((project) {
              return Tile(
                color: getColor(project.color),
                label: project.name,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfomartionHeader(UserLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Personal information",
            style: TextStyle(fontSize: 18, color: AppColors.grey),
          ),
          GestureDetector(
            child: const Text(
              "Edit",
              style: TextStyle(fontSize: 18, color: AppColors.primaryLight),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EditProfile(user: state.user))).then(
                (value) => init(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildPersonalInformation(UserLoaded state) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: CardDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Email:",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                state.user.email,
                style: const TextStyle(fontSize: 14),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Phone number:",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                state.user.phoneNumber,
                style: const TextStyle(
                    fontSize: 14, color: AppColors.primaryLight),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Address:",
                style: TextStyle(fontSize: 14),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    state.user.address,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        state.user.zipCode,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        state.user.city,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Text(
                    state.user.country,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void _onTapLogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }

  Widget _buildLogOutButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTapLogOut();
        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: CardDecoration(),
        child: const Center(
          child: Text(
            "Log out",
            style: TextStyle(fontSize: 14, color: AppColors.red),
          ),
        ),
      ),
    );
  }
}
