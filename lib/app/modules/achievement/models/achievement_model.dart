import 'package:flutter/material.dart';

class PersonalRecordModel {
  final String id;
  final String title;
  final String date;
  final String? valueLabel;
  final String? imageAsset;
  final Color accentColor;
  final Color softColor;

  const PersonalRecordModel({
    required this.id,
    required this.title,
    required this.date,
    this.valueLabel,
    this.imageAsset,
    required this.accentColor,
    required this.softColor,
  });
}

class AchievementModel {
  final String id;
  final String title;
  final int currentTier;
  final int totalTiers;
  final String? badgeNumber;
  final String? imageAsset;
  final bool isNew;
  final bool isUnlocked;
  final Color accentColor;
  final Color softColor;

  const AchievementModel({
    required this.id,
    required this.title,
    required this.currentTier,
    required this.totalTiers,
    this.badgeNumber,
    this.imageAsset,
    this.isNew = false,
    this.isUnlocked = true,
    required this.accentColor,
    required this.softColor,
  });

  String get progressText => '$currentTier dari $totalTiers';
}
