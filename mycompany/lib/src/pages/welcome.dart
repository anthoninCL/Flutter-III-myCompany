import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycompany/src/pages/create_company.dart';
import 'package:mycompany/src/widgets/app_subtitle.dart';
import 'package:mycompany/src/widgets/main_button.dart';
import 'package:mycompany/src/widgets/app_title.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  void onButtonPressed(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const CreateCompanyScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/welcome_screen_image.png",
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  const AppTitle(
                                    title: "Create a real\nwork environment",
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const AppSubtitle(
                                    title:
                                        "It’s time to create your company in our application to manage projects, meetings, ...",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 60, top: 10),
                              child: MainButton(
                                title: "Get started",
                                onPressed: () => onButtonPressed(context),
                                centerIcon: Icons.arrow_forward,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ));
  }
}
