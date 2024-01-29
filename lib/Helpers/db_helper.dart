import 'dart:async';
import 'dart:io' as io;
import 'package:dbsproject/models/matchesModal.dart';
import 'package:dbsproject/models/squadmodal.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "primer_league.db");
    bool dbExists = await io.File(path).exists();

    if (!dbExists) {
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "primer_league.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(path).writeAsBytes(bytes, flush: true);
    }

    var theDb = await openDatabase(path, version: 1);
    return theDb;
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    var dbClient = await db;
    return dbClient!.query(table);
  }

  Future<void> addfixture(MatchData newfixture) async {
    var dbClient = await db;
    await dbClient!.insert('matches', {
      'match_id': newfixture.matchId,
      'home_team_id': newfixture.homeTeamId,
      'away_team_id': newfixture.awayTeamId,
      'home_team_goal': newfixture.homeTeamGoals,
      'away_team_goal': newfixture.awayTeamGoals,
      'stadium_id': newfixture.homeTeamId,
      'did_played': newfixture.completed,
    });
  }

  Future<void> updatefixture(MatchData newfixture) async {
    var dbClient = await db;
    await dbClient!.update(
        'matches',
        {
          'home_team_id': newfixture.homeTeamId,
          'away_team_id': newfixture.awayTeamId,
          'home_team_goal': newfixture.homeTeamGoals,
          'away_team_goal': newfixture.awayTeamGoals,
          'stadium_id': newfixture.homeTeamId,
          'did_played': newfixture.completed,
        },
        where: 'match_id = ?',
        whereArgs: [newfixture.matchId]);
  }

  Future<void> addPlayer(String table, Squad newpalyer) async {
    var dbClient = await db;
    await dbClient!.insert(table, {
      'team_id': newpalyer.teamId,
      'player_name': newpalyer.playerName,
      'player_position': newpalyer.playerPosition,
    });
  }

  Future<void> deletePlayer(String table, int playerId) async {
    var dbClient = await db;
    await dbClient!
        .delete(table, where: 'player_id = ?', whereArgs: [playerId]);
  }
}
