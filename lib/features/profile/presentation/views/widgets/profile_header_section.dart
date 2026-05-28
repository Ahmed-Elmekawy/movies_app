import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
import 'profile_stat_item.dart';

class ProfileHeaderSection extends StatelessWidget {
  final String avatarPath;
  final String name;
  final int watchListCount;
  final int historyCount;

  const ProfileHeaderSection({
    super.key,
    required this.avatarPath,
    required this.name,
    required this.watchListCount,
    required this.historyCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar & Name
          Column(
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundImage: AssetImage(avatarPath),
              ),
              16.verticalSpace,
              Text(
                name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          // Stats
          Expanded(
            child: Padding(
              padding: REdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileStatItem(
                    count: watchListCount.toString(),
                    label: context.l10n.watchlist,
                  ),
                  40.horizontalSpace,
                  ProfileStatItem(
                    count: historyCount.toString(),
                    label: context.l10n.history,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
