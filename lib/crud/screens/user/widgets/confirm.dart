import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context,
    {void Function()? onConfirm, void Function()? onCancel}) {
  // set up the buttons
  Widget cancelButton = GestureDetector(
    onTap: onCancel,
    child: const Text("Tidak"),
  );
  Widget continueButton = ElevatedButton(
    onPressed: onConfirm,
    child: const Text("Ya"),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    content: const Text("Apakah anda yakin ingin menghapus data ini?"),
    actions: [
      cancelButton,
      continueButton,
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
