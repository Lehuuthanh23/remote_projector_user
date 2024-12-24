import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_win/video_player_win.dart';

import '../app/app.locator.dart';
import '../app/utils.dart';

class ReviewVideoViewModel extends BaseViewModel {
  ReviewVideoViewModel(
      {required this.urlFile, required this.videoType, bool? initIsImage}) {
    _isImage = initIsImage ?? isImageUrl(urlFile);
  }

  final _navigationService = appLocator<NavigationService>();

  VideoPlayerController? mobileVideoController;
  WinVideoPlayerController? windowsVideoController;

  final String urlFile;
  final int videoType;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  bool _isImage = false;
  bool get isImage => _isImage;

  double _currentPosition = 0.0;
  double get currentPosition => _currentPosition;

  Future<void> initialise() async {
    if (_isImage) {
      if (videoType != 1 && !await isImageUrlValid(urlFile)) {
        _navigationService.back();
      }
    } else {
      if (!kIsWeb) {
        if (Platform.isWindows) {
          await initialiseWindows();
        } else if (Platform.isAndroid || Platform.isIOS) {
          await initialiseMobile();
        }
      }
    }

    notifyListeners();
  }

  Future<void> initialiseWindows() async {
    if (videoType == 1) {
      windowsVideoController = WinVideoPlayerController.file(File(urlFile));
    } else {
      if (await isVideoUrlValid(urlFile)) {
        windowsVideoController = WinVideoPlayerController.network(urlFile);
      } else {
        _navigationService.back();
      }
    }
    windowsVideoController!
      ..initialize().then((_) {
        windowsVideoController!.play();
        _isPlaying = true;
        windowsVideoController!.addListener(() {
          _currentPosition =
              windowsVideoController!.value.position.inSeconds.toDouble();
          notifyListeners();
        });
      })
      ..setLooping(true);
  }

  Future<void> initialiseMobile() async {
    if (videoType == 1) {
      mobileVideoController = VideoPlayerController.file(File(urlFile));
    } else {
      if (await isVideoUrlValid(urlFile)) {
        mobileVideoController =
            VideoPlayerController.networkUrl(Uri.parse(urlFile));
      } else {
        _navigationService.back();
      }
    }
    mobileVideoController!
      ..initialize().then((_) {
        mobileVideoController!.play();
        _isPlaying = true;
        mobileVideoController!.addListener(() {
          _currentPosition =
              mobileVideoController!.value.position.inSeconds.toDouble();
          notifyListeners();
        });
      })
      ..setLooping(true);
  }

  @override
  void dispose() {
    mobileVideoController?.dispose();
    windowsVideoController?.dispose();

    super.dispose();
  }

  bool isControllerAlready() {
    if (!kIsWeb) {
      if (Platform.isWindows) {
        return windowsVideoController != null &&
            windowsVideoController!.value.isInitialized;
      } else if (Platform.isIOS || Platform.isAndroid) {
        return mobileVideoController != null &&
            mobileVideoController!.value.isInitialized;
      }
    }

    return false;
  }

  double getAspectRatio() {
    double? aspectRatio;

    if (!kIsWeb) {
      if (Platform.isWindows) {
        aspectRatio = windowsVideoController?.value.aspectRatio;
      } else if (Platform.isAndroid || Platform.isIOS) {
        aspectRatio = mobileVideoController?.value.aspectRatio;
      }
    }

    return aspectRatio ?? (16 / 9);
  }

  double getMaxDurationInVideo() {
    double? max;

    if (!kIsWeb) {
      if (Platform.isWindows) {
        max = windowsVideoController?.value.duration.inSeconds.toDouble();
      } else if (Platform.isAndroid || Platform.isIOS) {
        max = mobileVideoController?.value.duration.inSeconds.toDouble();
      }
    }

    return max ?? 1;
  }

  String getTextCurrentPosition() {
    String? text;
    Duration? maxDuration;

    if (!kIsWeb) {
      if (Platform.isWindows) {
        maxDuration = windowsVideoController?.value.duration;
      } else if (Platform.isAndroid || Platform.isIOS) {
        maxDuration = mobileVideoController?.value.duration;
      }
    }

    if (maxDuration != null) {
      text = '${formatDuration(Duration(seconds: _currentPosition.toInt()))} / '
          '${formatDuration(maxDuration)}';
    }

    return text ?? '';
  }

  void onChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      windowsVideoController?.pause();
      mobileVideoController?.pause();
    } else if (state == AppLifecycleState.resumed) {
      if (_isPlaying) {
        windowsVideoController?.play();
        mobileVideoController?.play();
      }
    }
  }

  void changePlayState() {
    if (!kIsWeb) {
      if (Platform.isWindows) {
        _changePlayStateWindows();
      } else if (Platform.isAndroid || Platform.isIOS) {
        _changePlayStateMobile();
      }
    }
  }

  void seekTo(double seconds) {
    if (!kIsWeb) {
      if (Platform.isWindows) {
        windowsVideoController!.seekTo(Duration(seconds: seconds.toInt()));
      } else if (Platform.isAndroid || Platform.isIOS) {
        mobileVideoController!.seekTo(Duration(seconds: seconds.toInt()));
      }
    }
  }

  void _changePlayStateMobile() {
    if (mobileVideoController?.value.isPlaying == true) {
      mobileVideoController!.pause();
      _isPlaying = false;
    } else {
      mobileVideoController!.play();
      _isPlaying = true;
    }
  }

  void _changePlayStateWindows() {
    if (windowsVideoController?.value.isPlaying == true) {
      windowsVideoController!.pause();
      _isPlaying = false;
    } else {
      windowsVideoController!.play();
      _isPlaying = true;
    }
  }
}
