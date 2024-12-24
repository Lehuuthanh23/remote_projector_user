class Api {
  Api._();

  // Config
  static const String configApi = 'https://gtglobal.com.vn/config6789.php';

  // Host URL
  static String hostApi = 'https://api6789.web5sao.net';

  // Authentication & User Fetch URL
  static const String login = '/home/login';
  static const String signUp = '/home/register';
  static const String sendCode = '/home/SendCode';
  static const String resetPassword = '/home/resetpass';
  static const String getCustomer = '/home/GetInfoCustomer_ById';
  static const String changePassword = '/home/changepass';
  static const String updateCustomer = '/home/UpdateInfoCustomer_ById';
  static const String getCustomerByEmail = '/home/GetInfoCustomer_ByEmail';
  static const String getListAdminId = '/sysaccount/GetListAccount';

  // Packet URL
  static const String getAllPacket = '/home/GetAllPacket';
  static const String buyPacketByIdCustomer = '/home/BuyPacket_ByIdCustomer';
  static const String getPacketByCustomerId = '/home/GetPacket_ByCustomerId';
  static const String cancelPacketById = '/home/CancelPacket_ById';

  // Directory Manager URL
  static const String getAllDir =
      '/home/GetShareDir_ByCustomerId/%5bcustomer_idfrom';
  static const String getCustomerDir = '/home/GetDirCustomer_ById';
  static const String getShareDir = '/home/GetDirCustomer_SharedById';
  static const String getDirectoriesSharedFromCustomerId =
      '/home/GetShareDir_ByCustomerId';
  static const String createDir = '/home/CreateDir';
  static const String updateDir = '/home/UpDateDir_ById';
  static const String deleteDir = '/home/DeleteDir_ById';
  static const String shareDir = '/home/InsertDirShare';
  static const String getSharedCustomerListByDirId =
      '/home/GetSharedCustomerList_ByDirID';
  static const String deleteDirectoryShared = '/home/DeleteDir_shared';

  // Device Manager URL
  static const String getDeviceByComputerId = '/home/GetDevice_ByComputerID';
  static const String getExternalDevices =
      '/home/GetDevicesNotBelongAnyDir_ByCustomerId';
  static const String createDevice = '/home/CreateDevice';
  static const String getDeviceByIdDir = '/home/GetDevice_ByIdDir';
  static const String updateDevice = '/home/UpDateDevice_ById';
  static const String deleteDevice = '/home/DeleteDevice_ById';
  static const String getDeviceOfCampByCampId =
      '/home/GetListDeviceOfCamp_ByCampId';
  static const String shareDevice = '/home/InsertDeviceShare';
  static const String getSharedCustomerListByComputerId =
      '/home/GetSharedCustomerList_ByComputeID';
  static const String getDeviceCustomerSharedById =
      '/home/GetDeviceCustomer_SharedById';
  static const String getDeviceSharedFromCustomerId =
      '/home/GetSharedDevices_ByCustomerId';
  static const String deleteDeviceShared = '/home/DeleteDevice_shared';

  // Campaign Manager URL
  static const String getShareCamp = '/home/GetShareCamp_ByCustomerId';
  static const String getCampSharedByIdCustomer =
      '/home/GetCamp_SharedByCustomerId';
  static const String getCampByIdDevice = '/home/Getcamp_ByComputerId';
  static const String getAllCampByIdCustomer = '/home/GetAllCamp_ById';
  static const String createCamp = '/home/CreateCamp';
  static const String updateCampById = '/home/UpdateCamp_ById';
  static const String deleteCampById = '/home/DeleteCamp_ById';
  static const String getCampaignRunProfile = '/home/GetCampaignRunProfile';
  static const String getStatisticsCampaignRunProfileGeneral =
      '/home/GetCampaignRunProfile_Genaral';
  static const String updateStatusCampaign = '/home/ApproveCamp_ById';
  static const String getCampaignByDirectoryId = '/home/Getcamp_ByDirId';

  // Manage Campaign Time Run URL
  static const String getTimeRunByCampId = '/home/GetTimeRun_ByCampId';
  static const String addTimeRunByCampaignId = '/home/AddTimeRun_ByCamp';
  static const String deleteTimRunByIdRun = '/home/DeleteTimeRun_ByIdRun';
  static const String updateTimeRunByIdRun = '/home/UpdateTimeRun_ByIdRun';

  // Notification URL
  static const String getNotificationByCustomerId =
      '/home/GetNofity_ByIdCustomer';
  static const String getNewNotificationByCustomerId =
      '/home/GetNofityNew_ByIdCustomer';
  static const String updateNotification = '/home/UpdateNotify';
  static const String createNotification = '/home/InsertNotify';
  static const String createAdminNotification = '/home/InsertNotify_Account';

  // Resource Manager URL
  static const String checkDirectoryResourceExist = '/home/checkdir_customer';
  static const String getFilesFromDirectoryResource = '/home/getfiles_customer';
  static const String uploadFileToDirectoryResource =
      '/home/uploadfile_customer';
  static const String createDirectoryResource = '/home/createdir_customer';
  static const String getSizeDirectoryResource = '/home/getsizeofdir_customer';
  static const String deleteFileFromDirectoryResource =
      '/home/deletefile_customer';

  // Command URL
  static const String createCommand = '/home/CreateCommand';
  static const String getInfoCommandByID = '/home/GetInfoCommand_ByID';
}
