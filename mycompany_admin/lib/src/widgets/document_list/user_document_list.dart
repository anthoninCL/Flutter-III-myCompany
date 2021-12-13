import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/blocs/company/company_bloc.dart';
import 'package:mycompany_admin/src/widgets/classic_text_input.dart';
import 'package:mycompany_admin/src/widgets/forms/user_form.dart';
import 'package:mycompany_admin/src/widgets/generic_button.dart';
import 'package:mycompany_admin/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../list_item.dart';

class UserDocumentList extends StatefulWidget {
  const UserDocumentList(
      {Key? key, required this.onChangeForm})
      : super(key: key);

  final Function(Widget) onChangeForm;

  @override
  _UserDocumentListState createState() => _UserDocumentListState();
}

class _UserDocumentListState extends State<UserDocumentList> {
  final TextEditingController _searchTextController = TextEditingController();
  final CompanyBloc _companyBloc = CompanyBloc();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getString("companyId");
    if (companyId != null) {
      _companyBloc.add(GetCompany(companyId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(
        bloc: _companyBloc,
        builder: (context, state) {
          if (state is CompanyLoaded) {
            return Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(children: [
                  Expanded(
                    child: ClassicTextInput(
                      hintText: "Search",
                      isSecured: false,
                      textController: _searchTextController,
                      height: 40,
                      borderRadius: 10,
                      hasBorder: true,
                      color: AppColors.whiteDark,
                      borderColor: AppColors.greyLight,
                      alignment: Alignment.center,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GenericButton(
                      title: 'New',
                      onPressed: () {
                        widget.onChangeForm(UserForm(key: UniqueKey(),));
                      },
                      backColor: AppColors.primary,
                      fontColor: AppColors.white,
                      shadowColor: AppColors.primary),
                ]),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                height: MediaQuery.of(context).size.height * 0.80,
                child: ListView.builder(
                    itemCount: state.company.users.length,
                    itemBuilder: (context, index) {
                      String userName = state.company.users[index].firstName +
                          ' ' +
                          state.company.users[index].lastName;
                      return GestureDetector(
                        onTap: () {
                          widget.onChangeForm(UserForm(user: state.company.users[index], key: UniqueKey()));
                        },
                        child: ListItem(
                            name: userName, id: state.company.users[index].id),
                      );
                    }),
              ),
            ]);
          } else if (state is CompanyError) {
            return AlertDialog(
                title: Text('Error'),
                content: Text(state.error),
                actions: [
                  ElevatedButton(
                    child: Text('Got it'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ]);
          }
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
