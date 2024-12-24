import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../app/app_sp.dart';
import '../../app/app_sp_key.dart';
import '../../app/utils.dart';
import '../../models/user/authentication/request/sign_up_request_model.dart';
import '../../requests/authentication/authentication.request.dart';
import '../../view/authentication/sign_up_page.form.dart';
import '../../widget/pop_up.dart';

class SignUpViewModel extends FormViewModel {
  late BuildContext _context;

  final AuthenticationRequest _authenticationRequest = AuthenticationRequest();
  final _navigationService = appLocator<NavigationService>();

  final formKey = GlobalKey<FormState>();

  String? errorMessage;

  void setContext(BuildContext context) {
    _context = context;
  }

  void onSignupTaped() {
    if (formKey.currentState!.validate()) {
      _handleSignup();
    }
  }

  Future<void> _handleSignup() async {
    final password = convertToMD5(passwordValue!);

    final user = SignUpRequestModel(
      email: emailValue!,
      password: password,
      name: nameValue!,
      phone: phoneValue!,
    );

    final error = await _authenticationRequest.signUp(user);

    if (error != null) {
      errorMessage = error;
    } else if (_context.mounted) {
      passwordValue = '';
      emailValue = '';
      phoneValue = '';
      nameValue = '';

      showPopupTwoButton(
        context: _context,
        barrierDismissible: false,
        title: 'Đăng kí tài khoản thành công, chuyển đến trang chủ?',
        onLeftTap: () {
          AppSP.set(AppSPKey.loginWith, 'email');
          _navigationService.clearStackAndShow(Routes.homePage);
        },
      );
    }
    notifyListeners();
  }
}
