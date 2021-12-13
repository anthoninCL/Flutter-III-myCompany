import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/classic_text_input.dart';
import 'package:mycompany_admin/src/widgets/forms/pole_form.dart';
import 'package:mycompany_admin/src/widgets/generic_button.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class PoleDocumentList extends StatefulWidget {
  const PoleDocumentList({Key? key, required this.data, required this.onChangeForm}) : super(key: key);

  final List<Widget> data;
  final Function(Widget) onChangeForm;

  @override
  _PoleDocumentListState createState() => _PoleDocumentListState();
}

class _PoleDocumentListState extends State<PoleDocumentList> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
        child: ListView(
          children: widget.data, // TODO
        ),
      ),
    ]);
  }
}
