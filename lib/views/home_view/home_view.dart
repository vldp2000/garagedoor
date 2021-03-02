import 'package:firstapp/views/home_view/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Garage Doors")),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 25, top: 25), child: Door(0)),
            Padding(padding: EdgeInsets.only(bottom: 25), child: Door(1)),
            Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: FlatButton(
                    color: Colors.blue,
                    child: Text(
                      'Refresh',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await refresh(context);
                    })),
            Selector<HomeViewModel, bool>(
                builder: (context, data, _) => TextField(
                    controller: TextEditingController()..text = Provider.of<HomeViewModel>(context).url,
                    decoration: InputDecoration(border: InputBorder.none, hintText: 'Enter the API URL'),
                    textAlign: TextAlign.center,
                    onChanged: (value) => Provider.of<HomeViewModel>(context, listen: false).url = value),
                selector: (buildContext, homeViewModel) => homeViewModel.isInit)
          ],
        )),
      ));
}

class Door extends StatelessWidget {
  final int doorId;

  Door(this.doorId);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
      Padding(padding: EdgeInsets.only(left: 25), child: Text(Provider.of<HomeViewModel>(context, listen: false).getDoorTitle(doorId))),
      Padding(
          padding: EdgeInsets.only(right: 25),
          child: Selector<HomeViewModel, bool>(
              builder: (context, data, _) => FlatButton(
                    child: Text(
                      "Toggle",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () async {
                      await refresh(context);

                      var value = Provider.of<HomeViewModel>(context, listen: false).getValue(doorId);

                      await showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                                content: new Text("The current door state is ${value ? "Opened" : "Closed"}. Toggle the Door state ?"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("NO"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("YES"),
                                    onPressed: () async {
                                      await Provider.of<HomeViewModel>(context, listen: false).setValue(doorId, !value, true, true);

                                      Navigator.of(context).pop();

                                      await refresh(context);
                                    },
                                  )
                                ],
                              ));
                    },
                  ),
              selector: (buildContext, homeViewModel) => homeViewModel.getValue(doorId)))
    ]);
  }
}

ProgressDialog createProgressDialog(BuildContext context) {
  final pr = new ProgressDialog(
    context,
    type: ProgressDialogType.Normal,
    textDirection: TextDirection.rtl,
    isDismissible: false,
  );

  pr.style(message: "...Please wait");

  return pr;
}

Future<T> showOKDialog<T>(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            content: new Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}

Future<void> refresh(BuildContext context) async {
  final progressDialog = createProgressDialog(context);

  try {
    await progressDialog.show();

    await Provider.of<HomeViewModel>(context, listen: false).refreshDoorsState();
  } on Exception catch (e) {
    await progressDialog.hide();

    await showOKDialog(context, e.toString());
  } finally {
    await progressDialog.hide();
  }
}
