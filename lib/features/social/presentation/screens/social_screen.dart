import 'package:flutter/material.dart';
import 'package:dharma_gyan/features/social/data/models/leaderboard_entry_model.dart';
import 'package:dharma_gyan/features/social/presentation/widgets/leaderboard_list_item_widget.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  late List<LeaderboardEntryModel> _leaderboardEntries;

  @override
  void initState() {
    super.initState();
    _loadSampleLeaderboardData();
  }

  void _loadSampleLeaderboardData() {
    // In a real app, this would be fetched from a service/API
    _leaderboardEntries = [
      LeaderboardEntryModel(
        rank: 1,
        name: 'Amal Mohammed',
        score: 499,
        avatarUrl: 'url1',
        isCurrentUser: true,
      ),
      LeaderboardEntryModel(
        rank: 2,
        name: 'Ahmed Sami',
        score: 410,
        avatarUrl: 'url2',
      ),
      LeaderboardEntryModel(
        rank: 3,
        name: 'Suad Ah.',
        score: 360,
        avatarUrl: 'url3',
      ),
      LeaderboardEntryModel(
        rank: 4,
        name: 'Sara Kami',
        score: 269,
        avatarUrl: 'url4',
      ),
      LeaderboardEntryModel(
        rank: 5,
        name: 'Reem Omar',
        score: 222,
        avatarUrl: 'url5',
      ),
      LeaderboardEntryModel(
        rank: 6,
        name: 'Rami Ahmed',
        score: 211,
        avatarUrl: 'url6',
      ),
      LeaderboardEntryModel(
        rank: 7,
        name: 'User Seven',
        score: 190,
        avatarUrl: 'url7',
      ),
      LeaderboardEntryModel(
        rank: 8,
        name: 'User Eight',
        score: 180,
        avatarUrl: 'url8',
      ),
      LeaderboardEntryModel(
        rank: 9,
        name: 'User Nine',
        score: 170,
        avatarUrl: 'url9',
      ),
      LeaderboardEntryModel(
        rank: 10,
        name: 'User Ten',
        score: 160,
        avatarUrl: 'url10',
      ),
    ];
    // Sort by rank just in case data isn't pre-sorted
    _leaderboardEntries.sort((a, b) => a.rank.compareTo(b.rank));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Leaderboard'),
            const SizedBox(width: 8),
            Icon(
              Icons.info_outline,
              color: theme.appBarTheme.foregroundColor?.withOpacity(0.7),
            ),
          ],
        ),
        // Potentially add tabs here for "Friends", "Global" if needed later
      ),
      body: Column(
        children: [
          // Top "Champion" Banner (from mockup)
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.emoji_events,
                  color: theme.colorScheme.primary,
                  size: 30,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Congratulations! You\'re the Champion of the Leaderboard! 🎉', // Or dynamic based on current user's rank
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Leaderboard List
          Expanded(
            child: ListView.builder(
              itemCount: _leaderboardEntries.length,
              itemBuilder: (context, index) {
                return LeaderboardListItemWidget(
                  entry: _leaderboardEntries[index],
                );
              },
            ),
          ),
          // "See More" button (from mockup)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.arrow_downward),
              label: const Text('See more'),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                side: BorderSide(color: theme.colorScheme.primary),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                // Handle "See more" action - e.g., load more entries
                print('See more tapped');
              },
            ),
          ),
        ],
      ),
    );
  }
}
