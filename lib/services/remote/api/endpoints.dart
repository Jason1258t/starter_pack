class ApiEndpoints {
  static const _version = '/v1';

  static const _auth = '$_version/auth';
  static const _user = '$_version/user';

  // ---------------------------------------

  static const refresh = '';

  static const authVerifyCode = '$_auth/verify';
  static const authSendEmailCode = "$_auth/login";

  static const user = '$_user/self';
  static const userWalletUpdate = '$_user/update/wallet';
  static const notifications = '$_user/notifications';
  static const readNotification = '$_user/notifications/read';
}
