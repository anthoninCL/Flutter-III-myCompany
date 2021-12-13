import 'package:flutter/cupertino.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.name, required this.id})
      : super(key: key);

  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        Flexible(
          child: Padding(
              padding: const EdgeInsets.all(20),
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.primary,
              ),
            )
          ),
        ),
      ]
    );
  }
}
