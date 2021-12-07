
import 'package:flutter/cupertino.dart';
import 'package:mycompany_admin/src/widgets/generic_button.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

import 'classic_text_input.dart';

class DocumentList extends StatefulWidget {
  const DocumentList({Key? key, required this.datas}) : super(key: key);

  final List<Widget> datas;

  @override
  State<StatefulWidget> createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                height: 40,
                child: ClassicTextInput(
                  hintText: "Search",
                  isSecured: false,
                  textController:
                  _searchTextController,
                  height: 60,
                  borderRadius: 10,
                  hasBorder: true,
                  color: AppColors.whiteDark,
                  borderColor: AppColors.greyLight,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const GenericButton(
                  title: 'Search',
                  onPressed: null,
                  backColor: AppColors.primary,
                  fontColor: AppColors.white,
                  shadowColor: AppColors.primary
              ),
            ]
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.22,
          height: MediaQuery.of(context).size.width * 0.35,
          child: ListView(
            children: widget.datas,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.22,
            height: 40,
            child: const GenericButton(
                title: 'Add new document',
                onPressed: null, // TODO: OUVRIR LA MODALE POUR CREER UN NOUVEAU DOC
                backColor: AppColors.green,
                fontColor: AppColors.white,
                shadowColor: AppColors.greenShadow,
              radius: 50,
            ),
          ),
        ),
      ]
    );
  }

}
