import 'package:firstapp/shared/services/api_service.dart';
import 'package:firstapp/views/home_view/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/locator.dart';

// import '../../locator.dart';
// import 'home_view_model.dart';
// import 'package:provider/provider.dart';
// import 'package:provider_architecture/core/enums/viewstate.dart';
// import 'package:provider_architecture/core/models/post.dart';
// import 'package:provider_architecture/core/models/user.dart';
// import 'package:provider_architecture/core/viewmodels/home_model.dart';
// import 'package:provider_architecture/ui/shared/app_colors.dart';
// import 'package:provider_architecture/ui/shared/text_styles.dart';
// import 'package:provider_architecture/ui/shared/ui_helpers.dart';
// import 'package:provider_architecture/ui/widgets/postlist_item.dart';

// import 'base_view.dart';

class TestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
        builder: (context, homeViewModel, _) => Scaffold(
              body: Column(children: [
                FlatButton(
                    color: Colors.blue,
                    child: Text(
                      'Gate 2',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {})
              ]),
            ));
  }
}
