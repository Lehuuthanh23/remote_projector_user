import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../app/utils.dart';
import '../../constants/app_color.dart';
import '../../view_models/authentication.view_model/signup.vm.dart';
import '../../widget/button_custom.dart';
import '../../widget/my_text_field.dart';
import 'sign_up_page.form.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'email'),
  FormTextField(name: 'phone'),
  FormTextField(name: 'password'),
  FormTextField(name: 'confirmPassword'),
])
class SignUpPage extends StackedView<SignUpViewModel> with $SignUpPage {
  const SignUpPage({super.key});

  @override
  Widget builder(
      BuildContext context, SignUpViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Họ và Tên'),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Xin vui lòng nhập Họ và Tên';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Xin hãy nhập email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: phoneController,
                    decoration:
                        const InputDecoration(labelText: 'Số điện thoại'),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Xin vui lòng nhập số điện thoại';
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Xin vui lòng nhập số điện thoại đúng định dạng';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  MyTextField(
                    controller: passwordController,
                    labelText: 'Mật khẩu',
                    isPasswordFields: true,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Xin hãy nhập mật khẩu';
                      }
                      if (!validatePassword(value)) {
                        return 'Mật khẩu phải từ 8 ký tự, bao gồm chữ, số và ký tự đặc biệt';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  MyTextField(
                    controller: confirmPasswordController,
                    labelText: 'Xác nhận mật khẩu',
                    isPasswordFields: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => viewModel.onSignupTaped(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Xin hãy nhập lại mật khẩu';
                      }
                      if (value != confirmPasswordController.text) {
                        return 'Mật khẩu chưa giống nhau';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Mật khẩu từ 8 ký tự, bao gồm chữ, số và ký tự đặc biệt',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.unSelectedLabel2,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  if (viewModel.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        viewModel.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ButtonCustom(
                    onPressed: viewModel.onSignupTaped,
                    title: "ĐĂNG KÝ",
                    textSize: 27,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  SignUpViewModel viewModelBuilder(BuildContext context) {
    SignUpViewModel viewModel = SignUpViewModel();
    viewModel.setContext(context);
    return viewModel;
  }

  @override
  void onViewModelReady(SignUpViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(SignUpViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }
}
