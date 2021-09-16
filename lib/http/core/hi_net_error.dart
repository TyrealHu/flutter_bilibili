// 网络请求异常统一基类
class HiNetError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  HiNetError(this.code, this.message, {this.data});
}

// 需要授权的异常处理
class NeedAuth extends HiNetError {
  NeedAuth(String message, {int code: 403, dynamic data})
      : super(code, message, data: data);
}

// 需要登录的异常处理
class NeedLogin extends HiNetError {
  NeedLogin({int code: 401, String message: '请先登录'})
      : super(code, message);
}
