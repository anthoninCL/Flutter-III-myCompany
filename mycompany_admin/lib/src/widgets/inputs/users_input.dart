import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiselect/multiselect.dart';
import 'package:mycompany_admin/src/blocs/company/company_bloc.dart';
import 'package:mycompany_admin/src/models/user.dart';
import 'package:mycompany_admin/src/widgets/dropdown_menu_widget.dart';
import 'package:mycompany_admin/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInput extends StatefulWidget {
  const UserInput(
      {Key? key,
      required this.multi,
      this.selectedItems,
      this.selectedItem,
      required this.fieldTitle,
      required this.onEmpty,
      this.onMultiChange,
      this.onChange})
      : super(key: key);

  final bool multi;
  final List<UserFront>? selectedItems;
  final UserFront? selectedItem;
  final String fieldTitle;
  final String onEmpty;
  final Function(List<UserFront>)? onMultiChange;
  final Function(UserFront)? onChange;

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
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
            return buildUserInput(context, state.company.users);
          } else if (state is CompanyError) {
            return AlertDialog(
                title: const Text('Error'),
                content: Text(state.error),
                actions: [
                  ElevatedButton(
                    child: const Text('Got it'),
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

  Widget buildUserInput(BuildContext context, List<UserFront> users) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 300,
            child: Text(
              widget.fieldTitle,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.black),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.3,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 20, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.black)),
              child: widget.multi
                  ? buildMultiSelectInput(context, users)
                  : buildSelectInput(context, users))
        ],
      ),
    );
  }

  Widget buildMultiSelectInput(BuildContext context, List<UserFront> users) {
    return DropDownMultiSelect(
      onChanged: (strings) {
        List<UserFront> newUsers = [];

        for (var string in strings) {
          newUsers.add(users
            .elementAt(users.indexWhere((e) => e.firstName == string)));
        }
        widget.onMultiChange!(newUsers);
      },
      options: users.map((user) => user.firstName).toList(),
      selectedValues:
          widget.selectedItems!.map((user) => user.firstName).toList(),
      childBuilder: buildChildItem,
      whenEmpty: widget.onEmpty,
      decoration: const InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          )),
    );
  }

  Widget buildSelectInput(BuildContext context, List<UserFront> users) {
    return DropDownMenuWidget(
        items: users.map((user) => user.firstName).toList(),
        changeItem: (string) {
          widget.onChange!(
              users.elementAt(users.indexWhere((e) => e.firstName == string)));
        },
        initialItem: widget.selectedItem?.firstName ??
            users.map((user) => user.firstName).toList()[0]);
  }

  Widget buildChildItem(List<String> selectedItems) {
    return Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedItems.isNotEmpty
                  ? selectedItems.reduce((a, b) => a + ' , ' + b)
                  : widget.onEmpty,
              style: TextStyle(
                  color: selectedItems.isNotEmpty
                      ? AppColors.black
                      : AppColors.grey,
                  fontSize: 20),
            ),
            const Icon(Icons.arrow_drop_down, color: AppColors.black, size: 32)
          ],
        ),
        alignment: Alignment.centerLeft);
  }
}
