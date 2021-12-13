import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/blocs/company/company_bloc.dart';
import 'package:mycompany_admin/src/widgets/classic_text_input.dart';
import 'package:mycompany_admin/src/widgets/forms/pole_form.dart';
import 'package:mycompany_admin/src/widgets/generic_button.dart';
import 'package:mycompany_admin/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../list_item.dart';

class PoleDocumentList extends StatefulWidget {
  const PoleDocumentList(
      {Key? key, required this.data, required this.onChangeForm})
      : super(key: key);

  final List<Widget> data;
  final Function(Widget) onChangeForm;

  @override
  _PoleDocumentListState createState() => _PoleDocumentListState();
}

class _PoleDocumentListState extends State<PoleDocumentList> {
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
                        widget.onChangeForm(const PoleForm());
                      },
                      backColor: AppColors.primary,
                      fontColor: AppColors.white,
                      shadowColor: AppColors.primary),
                ]),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                height: MediaQuery.of(context).size.height * 0.85,
                child: ListView.builder(
                    itemCount: state.company.poles.length,
                    itemBuilder: (context, index) {
                      return ListItem(
                          name: state.company.poles[index].name,
                          id: state.company.users[index].id);
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
