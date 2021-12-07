import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/app_title.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const AppTitle(title: 'MyCompany')
      ),
    );
  }

}
