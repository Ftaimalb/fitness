import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postgres/postgres.dart';

class DatabaseService {
  late final connection = PostgreSQLConnection(
    'localhost',
    5432,
    'test1',
    username: 'postgres',
    password: 'abc123',
  );
}
