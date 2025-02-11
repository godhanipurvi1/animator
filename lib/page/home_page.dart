import 'package:flutter/material.dart';
import 'package:planet/provider/planet_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<PlanetProvider>().getApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerR = context.watch<PlanetProvider>();
    var planets = providerR.planet;
    // return Scaffold(
    //     body: Center(
    //         child: Column(
    //   children: [
    //     if (providerR.planet == null) const Text("empty"),
    //     Text(providerR.planet?.first.order.toString() ?? "no"),
    //     Text(providerR.planet?.first.name.toString() ?? "no"),
    //   ],
    // )));
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.favorite_border), // Heart icon
              onPressed: () {
                Navigator.pushNamed(context, 'fav');
              })),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.5,
          ),
          itemCount: providerR.planet!.length,
          itemBuilder: (context, index) {
            final currentPlanet = providerR.planet![index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'details',
                  arguments: providerR.planet![index],
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(currentPlanet.name,
                    //     style: const TextStyle(
                    //         fontSize: 18, fontWeight: FontWeight.bold)),
                    Expanded(
                      // Use Expanded to handle text overflow
                      child: SingleChildScrollView(
                        // Add scrolling if content is too long
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text('Order: ${currentPlanet.order ?? "N/A"}'),
                            // Text(
                            //     'Diameter: ${currentPlanet.diameter_km ?? "N/A"} km'),
                            // Text('Mass: ${currentPlanet.mass_kg ?? "N/A"} kg'),
                            // Text(
                            //     'Orbital Period: ${currentPlanet.orbital_period_days ?? "N/A"} days'),
                            // Text(
                            //     'Orbital Distance: ${currentPlanet.orbital_distance_au ?? "N/A"} AU'),
                            // Text(
                            //     'Atmosphere: ${currentPlanet.atmosphere ?? "N/A"}'),
                            // Text('Moons: ${currentPlanet.moons ?? "N/A"}'),
                            Center(
                              child: Container(
                                  height: 200,
                                  child:
                                      Image.network(currentPlanet.image ?? "")),
                            ),
                            Center(
                              child: Text(
                                ' ${currentPlanet.name ?? "N/A"}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),

                            Text(
                                'Description: ${currentPlanet.description ?? "N/A"}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
