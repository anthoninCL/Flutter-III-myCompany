import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/blocs/meetings/meetings_bloc.dart';
import 'package:mycompany_admin/src/widgets/classic_text_input.dart';
import 'package:mycompany_admin/src/widgets/forms/meeting_form.dart';
import 'package:mycompany_admin/src/widgets/generic_button.dart';
import 'package:mycompany_admin/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../list_item.dart';

class MeetingDocumentList extends StatefulWidget {
  const MeetingDocumentList({Key? key, required this.data, required this.onChangeForm}) : super(key: key);

  final List<Widget> data;
  final Function(Widget) onChangeForm;

  @override
  _MeetingDocumentListState createState() => _MeetingDocumentListState();
}

class _MeetingDocumentListState extends State<MeetingDocumentList> {
  final TextEditingController _searchTextController = TextEditingController();
  final MeetingBloc _meetingBloc = MeetingBloc();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getString("companyId");
    if (companyId != null) {
      _meetingBloc.add(GetMeetingsCompany(companyId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _meetingBloc,
      builder: (context, state) {
        if (state is MeetingsLoaded) {
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
                      widget.onChangeForm(const MeetingForm());
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
                  itemCount: state.meetings.length,
                  itemBuilder: (context, index) {
                    return ListItem(
                        name: state.meetings[index].name,
                        id: state.meetings[index].id);
                  }),
            ),
          ]);
        } else if (state is MeetingError) {
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
      }
    );

  }
}
