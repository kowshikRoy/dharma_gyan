import 'package:flutter/material.dart';
import 'package:dharma_gyan/features/social/data/models/leaderboard_entry_model.dart';

class LeaderboardListItemWidget extends StatelessWidget {
  final LeaderboardEntryModel entry;

  const LeaderboardListItemWidget({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isTopThree = entry.rank <= 3;
    final Color? rankColor = isTopThree
        ? theme.colorScheme.primary
        : theme.textTheme.bodyLarge?.color;
    final FontWeight rankFontWeight = isTopThree
        ? FontWeight.bold
        : FontWeight.normal;

    return Card(
      elevation: entry.isCurrentUser ? 4.0 : 1.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: entry.isCurrentUser
            ? BorderSide(color: theme.colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${entry.rank}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: rankFontWeight,
                color: rankColor,
              ),
            ),
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 22,
              // backgroundImage: NetworkImage(entry.avatarUrl), // Assuming network images
              // For local asset placeholder:
              backgroundColor: Colors.grey.shade300,
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ), // Placeholder
            ),
          ],
        ),
        title: Text(
          entry.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${entry.score}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme
                    .colorScheme
                    .secondary, // Using secondary color for score
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.star,
              color: theme.colorScheme.secondary,
              size: 20,
            ), // Placeholder for gem/points icon
          ],
        ),
      ),
    );
  }
}
