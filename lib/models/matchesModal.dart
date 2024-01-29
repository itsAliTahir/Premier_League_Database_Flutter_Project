class MatchData {
  late int matchId;
  late int completed;
  late int homeTeamId;
  late int awayTeamId;
  late int matchStadiumId;
  late int homeTeamGoals;
  late int awayTeamGoals;

  MatchData(
      {required this.matchId,
      required this.completed,
      required this.homeTeamId,
      required this.awayTeamId,
      required this.matchStadiumId,
      required this.homeTeamGoals,
      required this.awayTeamGoals});
}
