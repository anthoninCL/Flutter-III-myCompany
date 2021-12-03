import 'package:flutter/material.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/config/themes/card_decoration.dart';
import 'package:mycompany/src/domain/entities/user.dart';
import 'package:mycompany/src/presentation/screens/edit_profile.dart';
import 'package:mycompany/src/presentation/widgets/custom_title.dart';
import 'package:mycompany/src/presentation/widgets/header_label.dart';
import 'package:mycompany/src/presentation/widgets/tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User user = const User(
      id: "a",
      firstName: "Thomas",
      lastName: "Hidalgo",
      email: "thomas.hidalgo@epitech.eu",
      password: "password",
      phoneNumber: "01 23 45 67 89",
      address: "3 rue Cecile Dubrovnik",
      zipCode: "31200",
      city: "Toulouse",
      country: "France",
      role: "User",
      tasks: ["tasks"],
      poles: ["poles"]);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle(label: "Thomas Hidalgo"),
            const SizedBox(
              height: 15,
            ),
            const HeaderLabel(label: "Information"),
            _buildInformation(),
            const SizedBox(
              height: 20,
            ),
            _buildPersonalInfomartionHeader(),
            _buildPersonalInformation(),
            const Spacer(),
            _buildLogOutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildInformation() {
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
            children: user.poles.map((pole) {
              return const Tile(
                color: Colors.white,
                label: "Development",
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
            children: const [
              Tile(color: Colors.orange, label: "ProjectName"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfomartionHeader() {
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
              Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfile(user: user)));
            },
          )
        ],
      ),
    );
  }

  Widget _buildPersonalInformation() {
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
                user.email,
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
                user.phoneNumber,
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
                    user.address,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        user.zipCode,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        user.city,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Text(
                    user.country,
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

  Widget _buildLogOutButton() {
    return GestureDetector(
      onTap: () {
        print("Log out user");
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
