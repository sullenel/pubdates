import 'package:flutter/material.dart';
import 'package:pubdates/common/utils/flutter_utils.dart';
import 'package:pubdates/features/home/widgets/home_app_bar.dart';
import 'package:pubdates/features/home/widgets/home_body.dart';
import 'package:pubdates/features/home/widgets/app_menu_bar.dart';
import 'package:pubdates/features/home/widgets/app_scope.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScope(
      child: AppMenuBar(
        child: Scaffold(
          backgroundColor: context.colorScheme.primary,
          appBar: const HomeAppBar(),
          body: const HomeBody(),
        ),
      ),
    );
  }
}
