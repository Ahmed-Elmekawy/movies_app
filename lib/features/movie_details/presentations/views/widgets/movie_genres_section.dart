import 'package:flutter/material.dart';

class MovieGenresSection extends StatelessWidget {
  final List<String> genres;

  const MovieGenresSection({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: genres.map((genre) {
        return Chip(
          label: Text(genre),
          side: BorderSide.none,
        );
      }).toList(),
    );
  }
}
