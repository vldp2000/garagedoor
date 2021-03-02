// import 'package:firstapp/shared/services/api_service.dart';
import 'dart:async';

import 'package:firstapp/shared/locator.dart';
import 'package:firstapp/shared/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends ChangeNotifier {
  bool _needToRefresh = true;

  bool isInit = false;

  var apiService = locator<ApiService>();

  String url;

  bool _door0Value = false;
  bool _door1Value = false;

  bool get needToRefresh => _needToRefresh;

  HomeViewModel() {
    var readUrlFuture = readUrl();

    readUrlFuture.then((_) async {
      isInit = true;

      notifyListeners();
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  setValue(int doorId, bool value, bool updateAPI, bool notify) async {
    if (url == null || url.isEmpty) return;

    if (updateAPI) {
      await saveUrl();

      value = await apiService.toggleDoor(url, doorId);
    }

    if (doorId == 0)
      _door0Value = value;
    else
      _door1Value = value;

    if (notify) notifyListeners();
  }

  String getDoorTitle(int doorId) {
    return "Door $doorId";
  }

  bool getValue(int doorId) {
    return doorId == 0 ? _door0Value : _door1Value;
  }

  Future<void> refreshDoorsState() async {
    if (url == null || url.isEmpty) return;

    await saveUrl();

    var result = await apiService.getDoorState(url, 0);

    setValue(0, result == 0 ? false : true, false, false);

    result = await apiService.getDoorState(url, 1);

    setValue(1, result == 0 ? false : true, false, false);

    _needToRefresh = false;

    notifyListeners();
  }

  Future<void> saveUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('url', url);
  }

  Future<void> readUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    url = prefs.getString('url');

    if (url == null || url.isEmpty) url = "http://youraddress.com/garage/door";
  }
}

// class HomeViewModel extends ChangeNotifier {
//   bool isInit = false;

//   var apiService = locator<ApiService>();

//   String url;

//   bool _switchValue = false;

//   List<bool> _isSelected1 = [false, false];
//   List<bool> _isSelected2 = [false, false];

//   HomeViewModel() {
//     var readUrlFuture = readUrl();

//     readUrlFuture.then((voidValue) {
//       isInit = true;

//       notifyListeners();
//     });
//   }

//   bool get switchValue {
//     return _switchValue;
//   }

//   set switchValue(bool value) {
//     _switchValue = value;
//     notifyListeners();
//   }

//   List<bool> get isSelected1 {
//     return _isSelected1;
//   }

//   List<bool> get isSelected2 {
//     return _isSelected2;
//   }

//   setIsSelectedIndex(int doorId, int index, bool updateAPI, bool notify) async {
//     if (url == null || url.isEmpty) return;

//     if (updateAPI) {
//       await saveUrl();

//       index = await apiService.setDoorState(url, doorId, index);
//     }

//     List<bool> isSelectedList;

//     if (doorId == 0)
//       isSelectedList = _isSelected1 = List.from(_isSelected1);
//     else
//       isSelectedList = _isSelected2 = List.from(_isSelected2);

//     for (int buttonIndex = 0; buttonIndex < isSelectedList.length; buttonIndex++) {
//       if (buttonIndex == index) {
//         isSelectedList[buttonIndex] = true;
//       } else {
//         isSelectedList[buttonIndex] = false;
//       }
//     }

//     if (notify) notifyListeners();
//   }

//   setValue(int doorId, bool value, bool updateAPI, bool notify) async {
//     if (url == null || url.isEmpty) return;

//     if (updateAPI) {
//       await saveUrl();

//       value = await apiService.setDoorState(url, doorId, value ? 1 : 0) == 0 ? false : true;
//     }

//     List<bool> isSelectedList;

//     if (doorId == 0)
//       isSelectedList = _isSelected1 = List.from(_isSelected1);
//     else
//       isSelectedList = _isSelected2 = List.from(_isSelected2);

//     for (int buttonIndex = 0; buttonIndex < isSelectedList.length; buttonIndex++) {
//       if (buttonIndex == index) {
//         isSelectedList[buttonIndex] = true;
//       } else {
//         isSelectedList[buttonIndex] = false;
//       }
//     }

//     if (notify) notifyListeners();
//   }

//   String getDoorTitle(int doorId) {
//     return "Door $doorId";
//   }

//   List<bool> getSelectedList(int doorId) {
//     return doorId == 0 ? _isSelected1 : _isSelected2;
//   }

//   List<bool> getValueList(int doorId) {
//     return doorId == 0 ? _isSelected1 : _isSelected2;
//   }

//   Future<void> refreshDoorsState() async {
//     if (url == null || url.isEmpty) return;

//     await saveUrl();

//     var result = await apiService.getDoorState(url, 0);

//     setIsSelectedIndex(0, result, false, false);

//     result = await apiService.getDoorState(url, 1);

//     setIsSelectedIndex(1, result, false, false);

//     notifyListeners();
//   }

//   Future<void> saveUrl() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     await prefs.setString('url', url);
//   }

//   Future<void> readUrl() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     url = prefs.getString('url');

//     if (url == null || url.isEmpty) url = "http://youraddress.com/garage/door";
//   }
// }
