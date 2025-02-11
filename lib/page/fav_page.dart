import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/planet_model.dart';
import '../provider/planet_provider.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PlanetProvider>(
        builder: (context, providerR, child) {
          List<PlanetList> bookmarkedPlanets = providerR.bookmarkedPlanets;

          if (bookmarkedPlanets.isEmpty) {
            return Center(child: Text('No bookmarked planets yet!'));
          }

          return ListView.builder(
            itemCount: bookmarkedPlanets.length,
            itemBuilder: (context, index) {
              final planet = bookmarkedPlanets[index];

              return ListTile(
                leading: Icon(
                  Icons.bookmark,
                  color: Colors.blue,
                ),
                title: Text(planet.name ?? 'Unknown Planet'),
                // subtitle: Text('Some details about the planet'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    // Remove bookmark when pressed
                    providerR.toggleBookmark(planet);
                  },
                ),
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
