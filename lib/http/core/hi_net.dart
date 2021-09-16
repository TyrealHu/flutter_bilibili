import 'package:flutter_bilibili/http/core/hi_net_adapter.dart';
import 'package:flutter_bilibili/http/core/hi_net_error.dart';
import 'package:flutter_bilibili/http/core/mock_adapter.dart';
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
    HiNetResponse? resp;
    var error;

    try {
      resp = await send(req);
    } on HiNetError catch (e) {
      error = e;
      resp = e.data;
      printLog(e.message);
    } catch (e) {
      error = e;
      printLog(e);
    }

    if (resp == null) {
      printLog(error);
    }
    var result = resp?.data;
    printLog(result);

    var status = resp?.statusCode;

    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status!, result.toString(), data: result);
    }

    return result;
  }

  Future<dynamic> send<T>(BaseRequest req) async {
    printLog('url:${req.url()}');

    HiNetAdapter adapter = MockAdapter();
    return adapter.send(req);
  }

  void printLog(msg) {
    print('hi_net: ${msg.toString()}');
  }
}
