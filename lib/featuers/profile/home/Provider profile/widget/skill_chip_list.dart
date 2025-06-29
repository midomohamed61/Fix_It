import 'package:flutter/material.dart';

class SkillChipList extends StatelessWidget {
  final List<String> skills;

  const SkillChipList({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: skills.map((skill) => Chip(label: Text(skill))).toList(),
    );
  }
}
