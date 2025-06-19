class LeaderboardEntryModel {
  final int rank;
  final String name;
  final int score;
  final String avatarUrl; // Could be a local asset path or network URL
  final bool isCurrentUser; // To potentially highlight the current user

  LeaderboardEntryModel({
    required this.rank,
    required this.name,
    required this.score,
    required this.avatarUrl,
    this.isCurrentUser = false,
  });
}
