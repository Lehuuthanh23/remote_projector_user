// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i22;
import 'package:flutter/material.dart';
import 'package:remote_projector_2024/models/camp/camp_model.dart' as _i23;
import 'package:remote_projector_2024/models/config/config_model.dart' as _i28;
import 'package:remote_projector_2024/models/device/device_model.dart' as _i25;
import 'package:remote_projector_2024/models/dir/dir_model.dart' as _i24;
import 'package:remote_projector_2024/models/notification/notification_model.dart'
    as _i30;
import 'package:remote_projector_2024/models/packet/my_packet_model.dart'
    as _i32;
import 'package:remote_projector_2024/models/packet/packet_model.dart' as _i31;
import 'package:remote_projector_2024/view/account/change_password_page.dart'
    as _i4;
import 'package:remote_projector_2024/view/authentication/authentication_page.dart'
    as _i8;
import 'package:remote_projector_2024/view/authentication/create_new_password_page.dart'
    as _i15;
import 'package:remote_projector_2024/view/authentication/forgot_password_page.dart'
    as _i14;
import 'package:remote_projector_2024/view/camp/edit_camp_page.dart' as _i5;
import 'package:remote_projector_2024/view/camp/review_video_page.dart' as _i16;
import 'package:remote_projector_2024/view/camp_profile/camp_profile_page.dart'
    as _i13;
import 'package:remote_projector_2024/view/device/device_detail_page.dart'
    as _i7;
import 'package:remote_projector_2024/view/device/device_of_camp_page.dart'
    as _i17;
import 'package:remote_projector_2024/view/device/device_page.dart' as _i6;
import 'package:remote_projector_2024/view/home/home_page.dart' as _i3;
import 'package:remote_projector_2024/view/introduce/introduce_page.dart'
    as _i10;
import 'package:remote_projector_2024/view/notification/notification_detail_page.dart'
    as _i19;
import 'package:remote_projector_2024/view/notification/notification_page.dart'
    as _i18;
import 'package:remote_projector_2024/view/packet/packet_payment.dart' as _i21;
import 'package:remote_projector_2024/view/resource/resource_manager_page.dart'
    as _i20;
import 'package:remote_projector_2024/view/splash/splash_page.dart' as _i2;
import 'package:remote_projector_2024/view/start/start_page.dart' as _i12;
import 'package:remote_projector_2024/view/statistics/single_statistics_page.dart'
    as _i11;
import 'package:remote_projector_2024/view/web_view/my_web_view_page.dart'
    as _i9;
import 'package:remote_projector_2024/view_models/authentication.view_model/forgot_password.vm.dart'
    as _i29;
import 'package:remote_projector_2024/view_models/device.vm.dart' as _i27;
import 'package:remote_projector_2024/view_models/dir.vm.dart' as _i26;
import 'package:remote_projector_2024/view_models/packet.vm.dart' as _i33;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i34;

class Routes {
  static const splashPage = '/';

  static const homePage = '/home-page';

  static const changePasswordPage = '/change-password-page';

  static const editCampPage = '/edit-camp-page';

  static const devicePage = '/device-page';

  static const deviceDetailPage = '/device-detail-page';

  static const authenticationPage = '/authentication-page';

  static const myWebViewPage = '/my-web-view-page';

  static const introducePage = '/introduce-page';

  static const singleStatisticsPage = '/single-statistics-page';

  static const startPage = '/start-page';

  static const campProfilePage = '/camp-profile-page';

  static const forgotPasswordPage = '/forgot-password-page';

  static const createNewPasswordPage = '/create-new-password-page';

  static const reviewVideoPage = '/review-video-page';

  static const deviceOfCampPage = '/device-of-camp-page';

  static const notificationPage = '/notification-page';

  static const notificationDetailPage = '/notification-detail-page';

  static const resourceManagerPage = '/resource-manager-page';

  static const packetPaymentPage = '/packet-payment-page';

  static const all = <String>{
    splashPage,
    homePage,
    changePasswordPage,
    editCampPage,
    devicePage,
    deviceDetailPage,
    authenticationPage,
    myWebViewPage,
    introducePage,
    singleStatisticsPage,
    startPage,
    campProfilePage,
    forgotPasswordPage,
    createNewPasswordPage,
    reviewVideoPage,
    deviceOfCampPage,
    notificationPage,
    notificationDetailPage,
    resourceManagerPage,
    packetPaymentPage,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashPage,
      page: _i2.SplashPage,
    ),
    _i1.RouteDef(
      Routes.homePage,
      page: _i3.HomePage,
    ),
    _i1.RouteDef(
      Routes.changePasswordPage,
      page: _i4.ChangePasswordPage,
    ),
    _i1.RouteDef(
      Routes.editCampPage,
      page: _i5.EditCampPage,
    ),
    _i1.RouteDef(
      Routes.devicePage,
      page: _i6.DevicePage,
    ),
    _i1.RouteDef(
      Routes.deviceDetailPage,
      page: _i7.DeviceDetailPage,
    ),
    _i1.RouteDef(
      Routes.authenticationPage,
      page: _i8.AuthenticationPage,
    ),
    _i1.RouteDef(
      Routes.myWebViewPage,
      page: _i9.MyWebViewPage,
    ),
    _i1.RouteDef(
      Routes.introducePage,
      page: _i10.IntroducePage,
    ),
    _i1.RouteDef(
      Routes.singleStatisticsPage,
      page: _i11.SingleStatisticsPage,
    ),
    _i1.RouteDef(
      Routes.startPage,
      page: _i12.StartPage,
    ),
    _i1.RouteDef(
      Routes.campProfilePage,
      page: _i13.CampProfilePage,
    ),
    _i1.RouteDef(
      Routes.forgotPasswordPage,
      page: _i14.ForgotPasswordPage,
    ),
    _i1.RouteDef(
      Routes.createNewPasswordPage,
      page: _i15.CreateNewPasswordPage,
    ),
    _i1.RouteDef(
      Routes.reviewVideoPage,
      page: _i16.ReviewVideoPage,
    ),
    _i1.RouteDef(
      Routes.deviceOfCampPage,
      page: _i17.DeviceOfCampPage,
    ),
    _i1.RouteDef(
      Routes.notificationPage,
      page: _i18.NotificationPage,
    ),
    _i1.RouteDef(
      Routes.notificationDetailPage,
      page: _i19.NotificationDetailPage,
    ),
    _i1.RouteDef(
      Routes.resourceManagerPage,
      page: _i20.ResourceManagerPage,
    ),
    _i1.RouteDef(
      Routes.packetPaymentPage,
      page: _i21.PacketPaymentPage,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashPage: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashPage(),
        settings: data,
      );
    },
    _i3.HomePage: (data) {
      return _i22.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i3.HomePage(),
        settings: data,
        transitionsBuilder: data.transition ?? _i1.TransitionsBuilders.fadeIn,
      );
    },
    _i4.ChangePasswordPage: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.ChangePasswordPage(),
        settings: data,
      );
    },
    _i5.EditCampPage: (data) {
      final args = data.getArgs<EditCampPageArguments>(
        orElse: () => const EditCampPageArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.EditCampPage(
            key: args.key,
            campEdit: args.campEdit,
            dir: args.dir,
            computer: args.computer,
            autoApprove: args.autoApprove),
        settings: data,
      );
    },
    _i6.DevicePage: (data) {
      final args = data.getArgs<DevicePageArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i6.DevicePage(key: args.key, dirViewModel: args.dirViewModel),
        settings: data,
      );
    },
    _i7.DeviceDetailPage: (data) {
      final args = data.getArgs<DeviceDetailPageArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.DeviceDetailPage(
            key: args.key,
            device: args.device,
            currentDir: args.currentDir,
            deviceViewModel: args.deviceViewModel,
            dirViewModel: args.dirViewModel,
            inDir: args.inDir),
        settings: data,
      );
    },
    _i8.AuthenticationPage: (data) {
      final args = data.getArgs<AuthenticationPageArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.AuthenticationPage(key: args.key, index: args.index),
        settings: data,
      );
    },
    _i9.MyWebViewPage: (data) {
      final args = data.getArgs<MyWebViewPageArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.MyWebViewPage(key: args.key, url: args.url),
        settings: data,
      );
    },
    _i10.IntroducePage: (data) {
      final args = data.getArgs<IntroducePageArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i10.IntroducePage(key: args.key, configModel: args.configModel),
        settings: data,
      );
    },
    _i11.SingleStatisticsPage: (data) {
      final args = data.getArgs<SingleStatisticsPageArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i11.SingleStatisticsPage(key: args.key, camp: args.camp),
        settings: data,
      );
    },
    _i12.StartPage: (data) {
      final args = data.getArgs<StartPageArguments>(
        orElse: () => const StartPageArguments(),
      );
      return _i22.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i12.StartPage(key: args.key, animated: args.animated),
        settings: data,
        transitionsBuilder: data.transition ??
            (context, animation, secondaryAnimation, child) {
              return child;
            },
        transitionDuration: const Duration(milliseconds: 2000),
      );
    },
    _i13.CampProfilePage: (data) {
      final args = data.getArgs<CampProfilePageArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i13.CampProfilePage(key: args.key, campModel: args.campModel),
        settings: data,
      );
    },
    _i14.ForgotPasswordPage: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.ForgotPasswordPage(),
        settings: data,
      );
    },
    _i15.CreateNewPasswordPage: (data) {
      final args = data.getArgs<CreateNewPasswordPageArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.CreateNewPasswordPage(
            key: args.key,
            forgotPasswordViewModel: args.forgotPasswordViewModel),
        settings: data,
      );
    },
    _i16.ReviewVideoPage: (data) {
      final args = data.getArgs<ReviewVideoPageArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.ReviewVideoPage(
            key: args.key,
            urlFile: args.urlFile,
            videoType: args.videoType,
            isImage: args.isImage),
        settings: data,
      );
    },
    _i17.DeviceOfCampPage: (data) {
      final args = data.getArgs<DeviceOfCampPageArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i17.DeviceOfCampPage(key: args.key, campaign: args.campaign),
        settings: data,
      );
    },
    _i18.NotificationPage: (data) {
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => const _i18.NotificationPage(),
        settings: data,
      );
    },
    _i19.NotificationDetailPage: (data) {
      final args = data.getArgs<NotificationDetailPageArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.NotificationDetailPage(
            key: args.key, notification: args.notification),
        settings: data,
      );
    },
    _i20.ResourceManagerPage: (data) {
      final args = data.getArgs<ResourceManagerPageArguments>(
        orElse: () => const ResourceManagerPageArguments(),
      );
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i20.ResourceManagerPage(
            key: args.key, onChoseSuccess: args.onChoseSuccess),
        settings: data,
      );
    },
    _i21.PacketPaymentPage: (data) {
      final args = data.getArgs<PacketPaymentPageArguments>(nullOk: false);
      return _i22.MaterialPageRoute<dynamic>(
        builder: (context) => _i21.PacketPaymentPage(
            key: args.key,
            packet: args.packet,
            myPacket: args.myPacket,
            packetViewModel: args.packetViewModel),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class EditCampPageArguments {
  const EditCampPageArguments({
    this.key,
    this.campEdit,
    this.dir,
    this.computer,
    this.autoApprove = false,
  });

  final _i22.Key? key;

  final _i23.CampModel? campEdit;

  final _i24.Dir? dir;

  final _i25.Device? computer;

  final bool autoApprove;

  @override
  String toString() {
    return '{"key": "$key", "campEdit": "$campEdit", "dir": "$dir", "computer": "$computer", "autoApprove": "$autoApprove"}';
  }

  @override
  bool operator ==(covariant EditCampPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.campEdit == campEdit &&
        other.dir == dir &&
        other.computer == computer &&
        other.autoApprove == autoApprove;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        campEdit.hashCode ^
        dir.hashCode ^
        computer.hashCode ^
        autoApprove.hashCode;
  }
}

class DevicePageArguments {
  const DevicePageArguments({
    this.key,
    required this.dirViewModel,
  });

  final _i22.Key? key;

  final _i26.DirViewModel dirViewModel;

  @override
  String toString() {
    return '{"key": "$key", "dirViewModel": "$dirViewModel"}';
  }

  @override
  bool operator ==(covariant DevicePageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.dirViewModel == dirViewModel;
  }

  @override
  int get hashCode {
    return key.hashCode ^ dirViewModel.hashCode;
  }
}

class DeviceDetailPageArguments {
  const DeviceDetailPageArguments({
    this.key,
    required this.device,
    required this.currentDir,
    required this.deviceViewModel,
    required this.dirViewModel,
    required this.inDir,
  });

  final _i22.Key? key;

  final _i25.Device device;

  final _i24.Dir currentDir;

  final _i27.DeviceViewModel deviceViewModel;

  final _i26.DirViewModel dirViewModel;

  final bool inDir;

  @override
  String toString() {
    return '{"key": "$key", "device": "$device", "currentDir": "$currentDir", "deviceViewModel": "$deviceViewModel", "dirViewModel": "$dirViewModel", "inDir": "$inDir"}';
  }

  @override
  bool operator ==(covariant DeviceDetailPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.device == device &&
        other.currentDir == currentDir &&
        other.deviceViewModel == deviceViewModel &&
        other.dirViewModel == dirViewModel &&
        other.inDir == inDir;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        device.hashCode ^
        currentDir.hashCode ^
        deviceViewModel.hashCode ^
        dirViewModel.hashCode ^
        inDir.hashCode;
  }
}

class AuthenticationPageArguments {
  const AuthenticationPageArguments({
    this.key,
    required this.index,
  });

  final _i22.Key? key;

  final int index;

  @override
  String toString() {
    return '{"key": "$key", "index": "$index"}';
  }

  @override
  bool operator ==(covariant AuthenticationPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.index == index;
  }

  @override
  int get hashCode {
    return key.hashCode ^ index.hashCode;
  }
}

class MyWebViewPageArguments {
  const MyWebViewPageArguments({
    this.key,
    required this.url,
  });

  final _i22.Key? key;

  final String url;

  @override
  String toString() {
    return '{"key": "$key", "url": "$url"}';
  }

  @override
  bool operator ==(covariant MyWebViewPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.url == url;
  }

  @override
  int get hashCode {
    return key.hashCode ^ url.hashCode;
  }
}

class IntroducePageArguments {
  const IntroducePageArguments({
    this.key,
    required this.configModel,
  });

  final _i22.Key? key;

  final _i28.ConfigModel configModel;

  @override
  String toString() {
    return '{"key": "$key", "configModel": "$configModel"}';
  }

  @override
  bool operator ==(covariant IntroducePageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.configModel == configModel;
  }

  @override
  int get hashCode {
    return key.hashCode ^ configModel.hashCode;
  }
}

class SingleStatisticsPageArguments {
  const SingleStatisticsPageArguments({
    this.key,
    required this.camp,
  });

  final _i22.Key? key;

  final _i23.CampModel camp;

  @override
  String toString() {
    return '{"key": "$key", "camp": "$camp"}';
  }

  @override
  bool operator ==(covariant SingleStatisticsPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.camp == camp;
  }

  @override
  int get hashCode {
    return key.hashCode ^ camp.hashCode;
  }
}

class StartPageArguments {
  const StartPageArguments({
    this.key,
    this.animated = false,
  });

  final _i22.Key? key;

  final bool animated;

  @override
  String toString() {
    return '{"key": "$key", "animated": "$animated"}';
  }

  @override
  bool operator ==(covariant StartPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.animated == animated;
  }

  @override
  int get hashCode {
    return key.hashCode ^ animated.hashCode;
  }
}

class CampProfilePageArguments {
  const CampProfilePageArguments({
    this.key,
    required this.campModel,
  });

  final _i22.Key? key;

  final _i23.CampModel campModel;

  @override
  String toString() {
    return '{"key": "$key", "campModel": "$campModel"}';
  }

  @override
  bool operator ==(covariant CampProfilePageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.campModel == campModel;
  }

  @override
  int get hashCode {
    return key.hashCode ^ campModel.hashCode;
  }
}

class CreateNewPasswordPageArguments {
  const CreateNewPasswordPageArguments({
    this.key,
    required this.forgotPasswordViewModel,
  });

  final _i22.Key? key;

  final _i29.ForgotPasswordViewModel forgotPasswordViewModel;

  @override
  String toString() {
    return '{"key": "$key", "forgotPasswordViewModel": "$forgotPasswordViewModel"}';
  }

  @override
  bool operator ==(covariant CreateNewPasswordPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.forgotPasswordViewModel == forgotPasswordViewModel;
  }

  @override
  int get hashCode {
    return key.hashCode ^ forgotPasswordViewModel.hashCode;
  }
}

class ReviewVideoPageArguments {
  const ReviewVideoPageArguments({
    this.key,
    required this.urlFile,
    required this.videoType,
    this.isImage,
  });

  final _i22.Key? key;

  final String urlFile;

  final int videoType;

  final bool? isImage;

  @override
  String toString() {
    return '{"key": "$key", "urlFile": "$urlFile", "videoType": "$videoType", "isImage": "$isImage"}';
  }

  @override
  bool operator ==(covariant ReviewVideoPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.urlFile == urlFile &&
        other.videoType == videoType &&
        other.isImage == isImage;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        urlFile.hashCode ^
        videoType.hashCode ^
        isImage.hashCode;
  }
}

class DeviceOfCampPageArguments {
  const DeviceOfCampPageArguments({
    this.key,
    required this.campaign,
  });

  final _i22.Key? key;

  final _i23.CampModel campaign;

  @override
  String toString() {
    return '{"key": "$key", "campaign": "$campaign"}';
  }

  @override
  bool operator ==(covariant DeviceOfCampPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.campaign == campaign;
  }

  @override
  int get hashCode {
    return key.hashCode ^ campaign.hashCode;
  }
}

class NotificationDetailPageArguments {
  const NotificationDetailPageArguments({
    this.key,
    required this.notification,
  });

  final _i22.Key? key;

  final _i30.NotificationModel notification;

  @override
  String toString() {
    return '{"key": "$key", "notification": "$notification"}';
  }

  @override
  bool operator ==(covariant NotificationDetailPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.notification == notification;
  }

  @override
  int get hashCode {
    return key.hashCode ^ notification.hashCode;
  }
}

class ResourceManagerPageArguments {
  const ResourceManagerPageArguments({
    this.key,
    this.onChoseSuccess,
  });

  final _i22.Key? key;

  final void Function(String)? onChoseSuccess;

  @override
  String toString() {
    return '{"key": "$key", "onChoseSuccess": "$onChoseSuccess"}';
  }

  @override
  bool operator ==(covariant ResourceManagerPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.onChoseSuccess == onChoseSuccess;
  }

  @override
  int get hashCode {
    return key.hashCode ^ onChoseSuccess.hashCode;
  }
}

class PacketPaymentPageArguments {
  const PacketPaymentPageArguments({
    this.key,
    this.packet,
    this.myPacket,
    required this.packetViewModel,
  });

  final _i22.Key? key;

  final _i31.PacketModel? packet;

  final _i32.MyPacketModel? myPacket;

  final _i33.PacketViewModel packetViewModel;

  @override
  String toString() {
    return '{"key": "$key", "packet": "$packet", "myPacket": "$myPacket", "packetViewModel": "$packetViewModel"}';
  }

  @override
  bool operator ==(covariant PacketPaymentPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.packet == packet &&
        other.myPacket == myPacket &&
        other.packetViewModel == packetViewModel;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        packet.hashCode ^
        myPacket.hashCode ^
        packetViewModel.hashCode;
  }
}

extension NavigatorStateExtension on _i34.NavigationService {
  Future<dynamic> navigateToSplashPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomePage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homePage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChangePasswordPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.changePasswordPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditCampPage({
    _i22.Key? key,
    _i23.CampModel? campEdit,
    _i24.Dir? dir,
    _i25.Device? computer,
    bool autoApprove = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.editCampPage,
        arguments: EditCampPageArguments(
            key: key,
            campEdit: campEdit,
            dir: dir,
            computer: computer,
            autoApprove: autoApprove),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDevicePage({
    _i22.Key? key,
    required _i26.DirViewModel dirViewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.devicePage,
        arguments: DevicePageArguments(key: key, dirViewModel: dirViewModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDeviceDetailPage({
    _i22.Key? key,
    required _i25.Device device,
    required _i24.Dir currentDir,
    required _i27.DeviceViewModel deviceViewModel,
    required _i26.DirViewModel dirViewModel,
    required bool inDir,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.deviceDetailPage,
        arguments: DeviceDetailPageArguments(
            key: key,
            device: device,
            currentDir: currentDir,
            deviceViewModel: deviceViewModel,
            dirViewModel: dirViewModel,
            inDir: inDir),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthenticationPage({
    _i22.Key? key,
    required int index,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.authenticationPage,
        arguments: AuthenticationPageArguments(key: key, index: index),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMyWebViewPage({
    _i22.Key? key,
    required String url,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.myWebViewPage,
        arguments: MyWebViewPageArguments(key: key, url: url),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToIntroducePage({
    _i22.Key? key,
    required _i28.ConfigModel configModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.introducePage,
        arguments: IntroducePageArguments(key: key, configModel: configModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSingleStatisticsPage({
    _i22.Key? key,
    required _i23.CampModel camp,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.singleStatisticsPage,
        arguments: SingleStatisticsPageArguments(key: key, camp: camp),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartPage({
    _i22.Key? key,
    bool animated = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.startPage,
        arguments: StartPageArguments(key: key, animated: animated),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCampProfilePage({
    _i22.Key? key,
    required _i23.CampModel campModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.campProfilePage,
        arguments: CampProfilePageArguments(key: key, campModel: campModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgotPasswordPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.forgotPasswordPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateNewPasswordPage({
    _i22.Key? key,
    required _i29.ForgotPasswordViewModel forgotPasswordViewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.createNewPasswordPage,
        arguments: CreateNewPasswordPageArguments(
            key: key, forgotPasswordViewModel: forgotPasswordViewModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToReviewVideoPage({
    _i22.Key? key,
    required String urlFile,
    required int videoType,
    bool? isImage,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.reviewVideoPage,
        arguments: ReviewVideoPageArguments(
            key: key, urlFile: urlFile, videoType: videoType, isImage: isImage),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDeviceOfCampPage({
    _i22.Key? key,
    required _i23.CampModel campaign,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.deviceOfCampPage,
        arguments: DeviceOfCampPageArguments(key: key, campaign: campaign),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotificationPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.notificationPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotificationDetailPage({
    _i22.Key? key,
    required _i30.NotificationModel notification,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.notificationDetailPage,
        arguments: NotificationDetailPageArguments(
            key: key, notification: notification),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToResourceManagerPage({
    _i22.Key? key,
    void Function(String)? onChoseSuccess,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.resourceManagerPage,
        arguments: ResourceManagerPageArguments(
            key: key, onChoseSuccess: onChoseSuccess),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPacketPaymentPage({
    _i22.Key? key,
    _i31.PacketModel? packet,
    _i32.MyPacketModel? myPacket,
    required _i33.PacketViewModel packetViewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.packetPaymentPage,
        arguments: PacketPaymentPageArguments(
            key: key,
            packet: packet,
            myPacket: myPacket,
            packetViewModel: packetViewModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomePage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homePage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChangePasswordPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.changePasswordPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditCampPage({
    _i22.Key? key,
    _i23.CampModel? campEdit,
    _i24.Dir? dir,
    _i25.Device? computer,
    bool autoApprove = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.editCampPage,
        arguments: EditCampPageArguments(
            key: key,
            campEdit: campEdit,
            dir: dir,
            computer: computer,
            autoApprove: autoApprove),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDevicePage({
    _i22.Key? key,
    required _i26.DirViewModel dirViewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.devicePage,
        arguments: DevicePageArguments(key: key, dirViewModel: dirViewModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDeviceDetailPage({
    _i22.Key? key,
    required _i25.Device device,
    required _i24.Dir currentDir,
    required _i27.DeviceViewModel deviceViewModel,
    required _i26.DirViewModel dirViewModel,
    required bool inDir,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.deviceDetailPage,
        arguments: DeviceDetailPageArguments(
            key: key,
            device: device,
            currentDir: currentDir,
            deviceViewModel: deviceViewModel,
            dirViewModel: dirViewModel,
            inDir: inDir),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthenticationPage({
    _i22.Key? key,
    required int index,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.authenticationPage,
        arguments: AuthenticationPageArguments(key: key, index: index),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMyWebViewPage({
    _i22.Key? key,
    required String url,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.myWebViewPage,
        arguments: MyWebViewPageArguments(key: key, url: url),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithIntroducePage({
    _i22.Key? key,
    required _i28.ConfigModel configModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.introducePage,
        arguments: IntroducePageArguments(key: key, configModel: configModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSingleStatisticsPage({
    _i22.Key? key,
    required _i23.CampModel camp,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.singleStatisticsPage,
        arguments: SingleStatisticsPageArguments(key: key, camp: camp),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartPage({
    _i22.Key? key,
    bool animated = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.startPage,
        arguments: StartPageArguments(key: key, animated: animated),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCampProfilePage({
    _i22.Key? key,
    required _i23.CampModel campModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.campProfilePage,
        arguments: CampProfilePageArguments(key: key, campModel: campModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithForgotPasswordPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.forgotPasswordPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateNewPasswordPage({
    _i22.Key? key,
    required _i29.ForgotPasswordViewModel forgotPasswordViewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.createNewPasswordPage,
        arguments: CreateNewPasswordPageArguments(
            key: key, forgotPasswordViewModel: forgotPasswordViewModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithReviewVideoPage({
    _i22.Key? key,
    required String urlFile,
    required int videoType,
    bool? isImage,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.reviewVideoPage,
        arguments: ReviewVideoPageArguments(
            key: key, urlFile: urlFile, videoType: videoType, isImage: isImage),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDeviceOfCampPage({
    _i22.Key? key,
    required _i23.CampModel campaign,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.deviceOfCampPage,
        arguments: DeviceOfCampPageArguments(key: key, campaign: campaign),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotificationPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.notificationPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotificationDetailPage({
    _i22.Key? key,
    required _i30.NotificationModel notification,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.notificationDetailPage,
        arguments: NotificationDetailPageArguments(
            key: key, notification: notification),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithResourceManagerPage({
    _i22.Key? key,
    void Function(String)? onChoseSuccess,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.resourceManagerPage,
        arguments: ResourceManagerPageArguments(
            key: key, onChoseSuccess: onChoseSuccess),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPacketPaymentPage({
    _i22.Key? key,
    _i31.PacketModel? packet,
    _i32.MyPacketModel? myPacket,
    required _i33.PacketViewModel packetViewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.packetPaymentPage,
        arguments: PacketPaymentPageArguments(
            key: key,
            packet: packet,
            myPacket: myPacket,
            packetViewModel: packetViewModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
