import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ResourcePickerModel {
  int id;
  XFile? file;
  String type;
  double progress;
  int fileSize;
  CancelToken? cancelToken;

  ResourcePickerModel({
    required this.id,
    required this.type,
    required this.fileSize,
    this.file,
    this.progress = 0,
    this.cancelToken,
  });
}
