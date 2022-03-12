import 'package:flutter/material.dart';

class ProjectAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProjectAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // TODO: should display the project name and dependencies count
    // TODO: add a button to add/remove the project to/from bookmarks?
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        const CloseButton(),
      ],
    );
  }
}
