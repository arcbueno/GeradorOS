import 'dart:convert';
import 'dart:io';

import 'package:cli/api.dart';

Future<void> cli(List<String> arguments) async {
  // final parser = ArgParser();
  print('Digite sua base ou aperte enter para homologacao');
  var base = stdin.readLineSync(encoding: utf8);
  base = base == null || base.isEmpty ? 'homologacao' : base;
  final api = Api(base: base);

  print('Digite seu usuário');
  var user = stdin.readLineSync(encoding: utf8);
  if (user == null || user.isEmpty) {
    print('Usuário vazio');
    return;
  }

  print('Digite sua senha');
  var password = stdin.readLineSync(encoding: utf8);
  if (password == null || password.isEmpty) {
    print('Senha vazia');
    return;
  }

  print('Tentando login em $base');
  await api.login(user, password);
  print('Login feito com sucesso');

  print('A seguir vão ser pedidos os campos obrigatórios para a abertura');
  print(
      'Eu não vou validar, então faça o mínimo de inserir Ids válidos da base');
  print('Digite o id do setor');
  var setorId = stdin.readLineSync(encoding: utf8);
  print('Digite o id da oficina');
  var oficinaId = stdin.readLineSync(encoding: utf8);
  print('Digite o id da prioridade');
  var prioridadeId = stdin.readLineSync(encoding: utf8);
  print('Digite o id do tipo de manutencao');
  var tipoManutencaoId = stdin.readLineSync(encoding: utf8);
  print('Digite a observacao');
  var observacao = stdin.readLineSync(encoding: utf8);

  var resposta = await api.novaOS(int.parse(oficinaId!), int.parse(setorId!),
      int.parse(tipoManutencaoId!), int.parse(prioridadeId!), observacao!);
  if (resposta != null) {
    print('OS de número $resposta criada com sucesso');
  }
  print('Aperte enter para finalizar');
  stdin.readLineSync(encoding: utf8);
}
