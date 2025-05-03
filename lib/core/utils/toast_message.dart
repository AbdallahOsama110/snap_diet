import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'light_theme.dart';

void toastMessage(BuildContext context,
    {required String msg, required ToastType type}) {
  ToastContext().init(context);
  Color color = type == ToastType.success
      ? ColorName.primaryColor.withValues(alpha:.8)
      : type == ToastType.error
          ? Colors.red.withValues(alpha:.8)
          : Colors.grey.withValues(alpha:.8);

  Toast.show(
    msg,
    backgroundColor: color,
    duration: Toast.lengthLong,
    gravity: Toast.bottom,
  );
}

enum ToastType { success, error, other }
