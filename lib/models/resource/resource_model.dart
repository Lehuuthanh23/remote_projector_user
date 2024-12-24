class ResourceModel {
  String fileUrl;
  String fileName;
  String fileType;
  int fileSize;

  ResourceModel({
    required this.fileUrl,
    required this.fileName,
    required this.fileType,
    this.fileSize = 0,
  });
}
