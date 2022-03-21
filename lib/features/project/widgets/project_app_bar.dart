import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pubdates/common/widgets/space.dart';
import 'package:pubdates/features/project/bloc/project_bloc.dart';
import 'package:pubdates/features/project/bloc/project_state.dart';

class ProjectAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProjectAppBar({
    Key? key,
    this.withCloseAction = false,
  }) : super(key: key);

  final bool withCloseAction;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BlocSelector<ProjectBloc, ProjectState, String?>(
        selector: (state) => state.projectName,
        builder: (context, name) => name == null ? Nothing : Text(name),
      ),
      actions: [
        if (withCloseAction) const CloseButton(),
      ],
    );
  }
}
