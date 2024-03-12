import 'dart:async';
import 'dart:io';

// import 'package:path_provider/path_provider.dart';
import 'package:learn/learn_sqlite/tables_and_fields.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/card_details.dart';

class LearnDatabase {
  LearnDatabase._initialize();

  static final LearnDatabase learnDatabaseInstance =
      LearnDatabase._initialize();
  static const String _dbName = "learn.db";
  static Database? _db;
  static String path = "";

  Future<Database> get database async {
    _db ??= await _initializeDatabase();
    return _db!;
  }

  // deleteDatabase() {
  //   if (path.isEmpty) {
  //     databaseFactory.deleteDatabase(path);
  //   } else {
  //     print("no path found");
  //   }
  // }

  Future<Database> _initializeDatabase() async {
    print("----------------------inside initialize database ----------------");

    String databasesPath = await getDatabasesPath();
    path = join(databasesPath, _dbName);
    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (e) {
      print("path verification error : " + e.toString());
    }
    return await openDatabase(path, version: 1, onCreate: _configureDatabase);
  }

  FutureOr<void> _configureDatabase(Database db, int version) async {
    print("----------------------inside configure database-----------------");
    await createTableCardDetails(db);
    print("created table card details");
    print("----------------------------------------------------------------");
  }

  createTableCardDetails(Database db) async {
    db.execute('''
      CREATE TABLE ${Tables.cardDetails} (
        ${CardDetailsFields.id} ${FieldTypes.idTypeAT},
        ${CardDetailsFields.userId} ${FieldTypes.integerType},
        ${CardDetailsFields.cardNumber} ${FieldTypes.textType},
        ${CardDetailsFields.cvv} ${FieldTypes.integerType},
        ${CardDetailsFields.expirationDate} ${FieldTypes.textType},
        ${CardDetailsFields.nameOnCard} ${FieldTypes.textType}
      )
    ''');
  }

  Future<bool> insertCardDetails(CardDetails cardDetails) async {
    print(
        "------------------------Inside insert Card Dertails-----------------------");
    Database db = await database;

    final id = await db.insert(Tables.cardDetails, cardDetails.toJson());

    if (id == 0) {
      print("--------Failure----------");
      return false;
    }
    print("--------Success----------");
    return true;
  }

  Future close() async {
    final db = await database;
    db.close();
  }

  Future<CardDetails> getByIdUser(int id) async {
    print("----------------------inside get by user id -----------------");
    Database db = await database;
    print("----------------------starting the query -----------------");
    List<Map<String, Object?>> result = await db.query(
      Tables.cardDetails,
      where: "${CardDetailsFields.userId} == ?",
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      print("----------------------user found-----------------");
      return CardDetails.fromJson(result.first);
    } else {
      print("user id is none existent : $id not found");
      return CardDetails.isEmpty();
    }
  }
}
