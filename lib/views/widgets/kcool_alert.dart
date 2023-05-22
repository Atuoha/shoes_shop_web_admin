import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import '../../constants/color.dart';


Future kCoolAlert({
  required String message,
  required BuildContext context,
  required CoolAlertType alert,
  Function? action,
}) {
  return CoolAlert.show(
      backgroundColor: primaryColor,
      confirmBtnColor: accentColor,
      context: context,
      type: alert,
      text: message,
      onConfirmBtnTap: ()=>action!()
  );
}