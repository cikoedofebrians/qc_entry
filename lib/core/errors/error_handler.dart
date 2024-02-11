import 'package:flutter/material.dart';
import 'package:qc_entry/core/errors/failure.dart';
import 'package:qc_entry/presentation/shared/custom_snackbar.dart';

errorHandler(Failure? failure, BuildContext context, bool automaticPop) {
  if (failure != null) {
    if (failure is ServerFailure) {
      showQCEntrySnackBar(
          context: context,
          title: failure.message,
          withLogoutButton: failure.statusCode == 401,
          automaticPop: automaticPop);
    } else {
      showQCEntrySnackBar(context: context, title: failure.message);
    }
  }
}
