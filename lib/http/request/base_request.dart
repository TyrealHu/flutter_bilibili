// 接口文档地址 https://api.devio.org/uapi/swagger-ui.html#/;
// 封装枚举，http的请求方法
enum HttpMethod{ GET, POST, DELETE }

/*封装基础请求的抽象类
* 参数支持跟在?后面的参数  eg. www.a.com/api?id=tyreal
* 也支持path参数形式 eg. www.a.com/api/tyreal
* */
abstract class BaseRequest {
  var pathParams;
  var useHttps = true;

  // 获取域名
  String authority() {
    return 'api.devio.org';
  }

  // 获取path参数
  String path();

  // 获取http方法
  HttpMethod httpMethod();

  // 获取url
  String url() {
    Uri uri;
    var pathString = path();
    // 如果不是/结尾，则拼接/与参数
    if (pathParams != null) {
      if (pathString.endsWith('/')) {
        pathString = pathString + pathParams;
      } else {
        pathString = '$pathString/$pathParams';
      }
    }

    if (useHttps) {
      uri = Uri.https(authority(), pathString, pathParams);
    } else {
      uri = Uri.http(authority(), pathString, pathParams);
    }

    print('url${uri.toString()}');

    return uri.toString();
  }

  // 是否需要登录
  bool needLogin();

  // params的Map对象
  Map<String, String> params = Map();

  /*
  * 添加参数
  * 返回this可以支持链式调用
  * */
  BaseRequest add(String k, Object v) {
     params[k] = v.toString();
     return this;
  }

  // header的Map对象
  Map<String, dynamic> header = Map();
  // 添加header，同上
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}