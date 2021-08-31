import 'package:flutter_bilibili/http/request/base_request.dart';

class HiNet {
  HiNet._();

  static HiNet? _instance;

  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }

    return _instance!;
  }

  Future fire(BaseRequest req) async {
    var resp = await send(req);
    var result = resp['data'];
    printLog(result);

    return result;
  }

  Future<dynamic> send<T>(BaseRequest req) async {
    printLog('url:${req.url()}');
    printLog('method:${req.httpMethod()}');
    req.addHeader('token', '123');
    printLog('header:${req.header}');

    return Future.value({
      'statusCode': 200,
      'data': {
        'code': 0,
        'message': 'success'
      }
    });
  }

  void printLog(msg) {
    print('hi_net: ${msg.toString()}');
  }
}