import 'package:flutter/material.dart';
import '../atoms/app_card.dart';
import '../atoms/app_icon.dart';
import '../design_system/tokens/app_dimensions.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;

  const StatsCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cardColor = color ?? colorScheme.primary;
    
    return AppCard(
      elevation: AppCardElevation.low,
      onTap: onTap,
      backgroundColor: cardColor.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              AppIconContainer(
                iconData: icon,
                size: AppIconSize.medium,
                backgroundColor: cardColor.withOpacity(0.12),
                iconColor: cardColor,
              ),
              SizedBox(width: AppDimensions.spacing12),
              Expanded(
                child: Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.spacing12),
          Text(
            value,
            style: textTheme.headlineMedium?.copyWith(
              color: cardColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
