import 'package:flutter/material.dart';

import '../../../app/utils.dart';
import '../../../models/user/user.dart';
import '../../../view_models/device.vm.dart';

class SearchCustomerDialog extends StatefulWidget {
  final DeviceViewModel vm;
  final Function(String) onShareTap;

  const SearchCustomerDialog({
    super.key,
    required this.vm,
    required this.onShareTap,
  });

  @override
  State<SearchCustomerDialog> createState() => _SearchCustomerDialogState();

  static Future<void> show(
    BuildContext context,
    DeviceViewModel vm,
    Function(String) onShareTap,
  ) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SearchCustomerDialog(
          vm: vm,
          onShareTap: onShareTap,
        );
      },
    );
  }
}

class _SearchCustomerDialogState extends State<SearchCustomerDialog> {
  User? user;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFEB6E2C), Color(0xFFFABD1D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Email người nhận',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                child: ListBody(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: widget.vm.searchEmailController,
                            onSubmitted: (_) async {
                              User? fetchedUser = await widget.vm.getCustomer();
                              setState(() {
                                user = fetchedUser;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter email',
                              hintStyle: TextStyle(color: Colors.white70),
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () async {
                            User? fetchedUser = await widget.vm.getCustomer();
                            setState(() {
                              user = fetchedUser;
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Tìm kiếm'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (user != null)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tên: ${user!.customerName}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${isAllDigits(user?.email) ? 'SĐT' : 'Email'}: ${user!.email}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Hủy',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: user != null
                          ? () async {
                              String? userId = user?.customerId;
                              if (userId != null) {
                                widget.onShareTap(userId);
                              }
                            }
                          : null,
                      child: const Text(
                        'Chia sẻ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
