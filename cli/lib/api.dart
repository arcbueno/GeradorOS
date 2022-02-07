import 'package:dio/dio.dart';

class Api {
  final String base;
  String urlBase;
  RequestOptions? options;
  Dio securedDio;
  String? currentToken;

  Api({required this.base})
      : urlBase = 'https://$base.api.neovero.com/api',
        securedDio = Dio();

  Future<void> login(String user, String password) async {
    try {
      var response = await Dio().post(
        '$urlBase/Authentications/token',
        data: {'username': user, 'password': password},
      );
      var token = (response.data as Map<String, dynamic>)['acessToken'];
      currentToken = token;
      _configureDio(token);
    } catch (e) {
      if (e is DioError) {
        print(e.response!.data!['errors']);
      }
      rethrow;
    }
  }

  Future<String?> novaOS(int oficinaId, int setorId, int tipoManutencaoId,
      int prioridadeId, String observacao) async {
    try {
      var response = await Dio(
        BaseOptions(
          headers: {'Authorization': 'Bearer $currentToken'},
        ),
      ).post('$urlBase/OrdensServico', data: {
        'oficinaId': oficinaId,
        'setorId': setorId,
        'tipoManutencaoId': tipoManutencaoId,
        'prioridadeId': prioridadeId,
        'observacao': observacao
      });
      return response.data['numero'] as String;
    } catch (e) {
      if (e is DioError) {
        print(e.response!.data!);
      }
      rethrow;
    }
  }

  void _configureDio(String token) {
    securedDio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options, _) {
      options.headers['Authorization'] = 'Bearer $token';
      // print(options.data);
    }));
  }
}
