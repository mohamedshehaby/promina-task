import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showAlertDialog(
    {required BuildContext context,
    bool isLoading = false,
    required String title}) async {
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: [
                if (isLoading) const CircularProgressIndicator(),
                if (isLoading) 10.verticalSpace,
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          ),
        );
      });
}
