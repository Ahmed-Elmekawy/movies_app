import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_network_image.dart';

class MovieCastSection extends StatelessWidget {
  final List<Map<String, String>> cast;

  const MovieCastSection({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: List.generate(
        cast.length,
        (index) {
          final actor = cast[index];
          final name = actor['name'];
          final character = actor['character'];
          final image = actor['image'];

          return Card(
            margin: REdgeInsets.only(bottom: 12),
            child: Padding(
              padding: REdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: (image != null && image.isNotEmpty)
                        ? CustomNetworkImage(
                            imageUrl: image,
                            width: 80.w,
                            height: 80.h,
                          )
                        : Container(
                            width: 80.w,
                            height: 80.h,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                            child: Icon(
                              Icons.person,
                              size: 40.sp,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (name != null && name.isNotEmpty)
                          RichText(
                            text: TextSpan(
                              style: theme.textTheme.bodyMedium,
                              children: [
                                const TextSpan(text: 'Name : '),
                                TextSpan(
                                  text: name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        if (character != null && character.isNotEmpty) ...[
                          4.verticalSpace,
                          RichText(
                            text: TextSpan(
                              style: theme.textTheme.bodySmall,
                              children: [
                                const TextSpan(text: 'Character : '),
                                TextSpan(
                                  text: character,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
