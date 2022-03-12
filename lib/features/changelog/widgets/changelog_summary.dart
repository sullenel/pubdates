import 'package:flutter/material.dart';
import 'package:pubdates/common/constants/dimensions.dart';
import 'package:pubdates/common/constants/icons.dart';
import 'package:pubdates/common/widgets/space.dart';
import 'package:pubdates/features/changelog/models/changelog_content.dart';
import 'package:pubdates/features/changelog/models/package_changelog.dart';
import 'package:pubdates/features/changelog/widgets/html_content.dart';
import 'package:pubdates/features/project/models/package.dart';
import 'package:pubdates/features/project/models/package_update.dart';
import 'package:pubdates/localization/app_localizations.dart';

extension on PackageChangeLog {
  bool get hasLogs {
    return package.canBeUpgraded && logs.isNotEmpty;
  }
}

class ChangeLogSummary extends StatelessWidget {
  const ChangeLogSummary({
    Key? key,
    required this.changeLog,
    this.onPressed,
    this.onOpenPressed,
    this.showAll = false,
  }) : super(key: key);

  final PackageChangeLog changeLog;
  final VoidCallback? onPressed;
  final VoidCallback? onOpenPressed;
  final bool showAll;

  Iterable<ChangeLogContent> get _logs {
    return showAll ? changeLog.logs : changeLog.logsTillCurrentVersion;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppBorders.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ChangeLogHeader(
              onOpenPressed: onOpenPressed,
              package: changeLog.package,
            ),
            const Divider(height: 0),
            if (changeLog.hasLogs) ...[
              for (final log in _logs) ...[
                _VersionChangeLog(log: log),
                const Divider(height: 0),
              ],
              TextButton(
                onPressed: onPressed,
                child: Text(AppLocalizations.of(context).showAllAction),
              ),
            ] else
              const _NoChangeLog(),
          ],
        ),
      ),
    );
  }
}

class _ChangeLogHeader extends StatelessWidget {
  const _ChangeLogHeader({
    Key? key,
    required this.package,
    this.onOpenPressed,
  }) : super(key: key);

  final Package package;
  final VoidCallback? onOpenPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppInsets.lg),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (package.update != null) ...[
                  const VSpace(AppInsets.md),
                  _PackageVersions(update: package.update!),
                ],
              ],
            ),
          ),
          if (onOpenPressed != null) ...[
            const HSpace(AppInsets.lg),
            IconButton(
              onPressed: onOpenPressed,
              tooltip: t.openChangelogTooltip,
              icon: const Icon(AppIcons.openLink),
            ),
          ],
        ],
      ),
    );
  }
}

class _PackageVersions extends StatelessWidget {
  const _PackageVersions({
    Key? key,
    required this.update,
  }) : super(key: key);

  final PackageUpdate update;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.labelMedium;
    const separator = Text(' • ');

    return Row(
      children: [
        if (update.currentVersion != null)
          Text(
            t.currentVersion(update.currentVersion!),
            style: textStyle,
          ),
        if (update.upgradableVersion != null) ...[
          separator,
          Text(
            t.upgradableVersion(update.upgradableVersion!),
            style: textStyle,
          ),
        ],
        if (update.resolvableVersion != null) ...[
          separator,
          Text(
            t.resolvableVersion(update.resolvableVersion!),
            style: textStyle,
          ),
        ],
        if (update.latestVersion != null) ...[
          separator,
          Text(
            t.latestVersion(update.latestVersion!),
            style: textStyle,
          ),
        ],
      ],
    );
  }
}

class _VersionChangeLog extends StatelessWidget {
  const _VersionChangeLog({Key? key, required this.log}) : super(key: key);

  final ChangeLogContent log;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppInsets.lg),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              log.version,
              textAlign: TextAlign.end,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const HSpace(AppInsets.lg),
          Expanded(
            flex: 10,
            child: HtmlContent(text: log.content),
          ),
        ],
      ),
    );
  }
}

class _NoChangeLog extends StatelessWidget {
  const _NoChangeLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(AppInsets.lg),
      child: Text(
        AppLocalizations.of(context).noChangeLog,
        style: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.normal,
          color: textTheme.caption?.color,
        ),
      ),
    );
  }
}
