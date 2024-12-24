import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/app_sp.dart';
import '../../app/app_sp_key.dart';
import '../../constants/app_color.dart';
import '../../constants/app_constants.dart';
import '../../view_models/account.vm.dart';
import '../../widget/base_page.dart';
import '../../widget/button_custom.dart';
import '../../widget/pop_up.dart';
import 'widgets/account_list_title.dart';
import 'widgets/birth_date_picker.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
      viewModelBuilder: () => AccountViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.setContext(context);
        viewModel.initialise();
      },
      builder: (context, viewModel, child) {
        return BasePage(
          body: viewModel.isBusy
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      AccountListTile(
                        isCenter: true,
                        title: 'Đăng xuất',
                        leadingIcon: const Icon(
                          Icons.power_settings_new_rounded,
                          size: 24,
                          color: Color(0xff797979),
                        ),
                        onTap: () {
                          showPopupTwoButton(
                            title: 'Bạn có chắc chắn muốn đăng xuất không?',
                            leftText: 'Đăng xuất',
                            context: context,
                            onLeftTap: viewModel.signOut,
                          );
                        },
                      ),
                      AccountListTile(
                        customTitle: Row(
                          children: [
                            const Text('Hỗ trợ hotline: '),
                            Text(
                              '${viewModel.configModel?.hotline}',
                              style: const TextStyle(
                                color: AppColor.appBarStart,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        leadingIcon: Image.asset(
                          'assets/images/ic_phone.png',
                          width: 24,
                          height: 24,
                        ),
                        onTap: () {},
                      ),
                      AccountListTile(
                        leadingIcon: const Icon(
                          Icons.apps_rounded,
                        ),
                        trailingWidget: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: Color(0xffA4A4A4),
                        ),
                        title: 'Hướng dẫn sử dụng',
                        onTap: viewModel.toWebViewPage,
                      ),
                      AccountListTile(
                        title: 'Giới thiệu',
                        leadingIcon: const Icon(
                          Icons.info_outline_rounded,
                        ),
                        trailingWidget: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: Color(0xffA4A4A4),
                        ),
                        onTap: viewModel.toIntroducePage,
                      ),
                      const SizedBox(height: 20),
                      AccountListTile(
                        title: 'Quản lý tài nguyên',
                        leadingIcon: Image.asset(
                          'assets/images/ic_folder.png',
                          width: 24,
                          height: 24,
                        ),
                        trailingWidget: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: Color(0xffA4A4A4),
                        ),
                        onTap: viewModel.toResourceManagerPage,
                      ),
                      if (AppSP.get(AppSPKey.loginWith) != 'google')
                        AccountListTile(
                          title: 'Đổi mật khẩu',
                          leadingIcon: Image.asset(
                            'assets/images/ic_password.png',
                            width: 24,
                            height: 24,
                          ),
                          trailingWidget: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20,
                            color: Color(0xffA4A4A4),
                          ),
                          onTap: viewModel.toChangePasswordPage,
                        ),
                      const SizedBox(height: 20),
                      AccountListTile(
                        title: 'Họ & tên',
                        leadingIcon: Image.asset(
                          'assets/images/ic_profile.png',
                          width: 24,
                          height: 24,
                        ),
                        onTap: () => {},
                        customTitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Họ & tên',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff797979)),
                            ),
                            Text(
                              viewModel.currentUser?.customerName ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      BirthDatePicker(
                        currentUser: viewModel.currentUser,
                        onDatePicked: (DateTime? pickedDate) {
                          if (pickedDate != null) {
                            viewModel.currentUser?.dateOfBirth =
                                pickedDate.toString();
                            viewModel.notifyListeners();
                          }
                        },
                      ),
                      AccountListTile(
                        leadingIcon: Image.asset(
                          'assets/images/ic_sex.png',
                          width: 24,
                          height: 24,
                        ),
                        onTap: () {
                          showBottomChoseGender(
                            gender: AppConstants.genderList,
                            position: (position) {
                              viewModel.changeGender(position == 0
                                  ? null
                                  : AppConstants.genderList[position]);
                            },
                          );
                        },
                        customTitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Giới tính',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff797979),
                              ),
                            ),
                            Text(
                              viewModel.currentUser != null &&
                                      viewModel.currentUser!.sex != null &&
                                      viewModel.currentUser!.sex!.isNotEmpty
                                  ? viewModel.currentUser!.sex!
                                  : 'Thêm thông tin giới tính',
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColor.navUnSelect,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (AppSP.get(AppSPKey.loginWith) != 'google')
                        AccountListTile(
                          leadingIcon: Image.asset(
                            'assets/images/ic_phone_number.png',
                            width: 24,
                            height: 24,
                          ),
                          onTap: () {},
                          customTitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Số điện thoại',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.navUnSelect,
                                ),
                              ),
                              Text(
                                viewModel.currentUser?.phoneNumber ?? '',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      AccountListTile(
                        leadingIcon: Image.asset(
                          'assets/images/ic_email.png',
                          width: 24,
                          height: 24,
                        ),
                        onTap: () {},
                        customTitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Địa chỉ email',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColor.navUnSelect,
                              ),
                            ),
                            Text(
                              viewModel.currentUser?.email ?? '',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 70,
                          vertical: 20,
                        ),
                        child: ButtonCustom(
                          onPressed: viewModel.handleUpdateCustomer,
                          title: 'Lưu thông tin',
                          textSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Future<void> showBottomChoseGender(
      {required List<String> gender,
      required ValueChanged<int> position}) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Chọn giới tính',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: gender.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(gender[index]),
                        onTap: () {
                          position.call(index);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
