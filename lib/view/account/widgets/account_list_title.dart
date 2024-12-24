import 'package:flutter/material.dart';

class AccountListTile extends StatelessWidget {
  final String? title;
  final Widget leadingIcon;
  final Widget? trailingWidget;
  final VoidCallback onTap;
  final bool isCenter;
  final Widget? customTitle;

  const AccountListTile({
    super.key,
    this.title,
    required this.leadingIcon,
    this.customTitle,
    this.trailingWidget,
    this.isCenter = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade100,
          width: 1.0,
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 30, right: 15),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: leadingIcon,
          ),
          const SizedBox(width: 10),
          isCenter
              ? Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                )
              : customTitle ??
                  Expanded(
                    child: Text(
                      title ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
          if (trailingWidget != null) trailingWidget!,
        ],
      ),
      onTap: onTap,
    );
  }
}
