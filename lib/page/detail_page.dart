import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/planet_model.dart';
import '../provider/planet_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(); // This will make the rotation repeat

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var providerR = context.watch<PlanetProvider>();

    final PlanetList planet =
        ModalRoute.of(context)!.settings.arguments as PlanetList;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            providerR.isBookmarked(planet.name ?? '')
                ? Icons.bookmark
                : Icons.bookmark_border,
            color: providerR.isBookmarked(planet.name ?? '')
                ? Colors.blue
                : Colors.grey,
          ),
          tooltip: providerR.isBookmarked(planet.name ?? '')
              ? 'Remove Bookmark'
              : 'Add Bookmark',
          onPressed: () {
            providerR.toggleBookmark(planet);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (planet.image != null)
              // Using AnimatedBuilder to apply rotation animation to the image
              AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation
                        .value, // Dynamically applying rotation
                    child: child,
                  );
                },
                child: Image.network(planet.image!),
              ),
            SizedBox(height: 16),

            // Planet Name
            Text(
              planet.name ?? 'Unknown Planet',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Description
            Text(
              planet.description ?? 'No description available.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Planet's Orbital Period
            Text(
              'Orbital Period: ${planet.orbital_period_days ?? 'N/A'} days',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),

            // Planet's Mass
            Text(
              'Mass: ${planet.mass_kg != null ? planet.mass_kg.toString() + ' kg' : 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),

            // Planet's Diameter
            Text(
              'Diameter: ${planet.diameter_km != null ? planet.diameter_km.toString() + ' km' : 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),

            // Planet's Orbital Distance from the Sun
            Text(
              'Distance from Sun: ${planet.orbital_distance_au != null ? planet.orbital_distance_au.toString() + ' AU' : 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),

            // Number of Moons
            Text(
              'Moons: ${planet.moons ?? 0}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Display Moon List (if available)
            if (planet.moon_list != null && planet.moon_list!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Moons:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...planet.moon_list!.map((moon) => Text(moon)).toList(),
                ],
              ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
