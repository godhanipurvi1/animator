// class PlanetModel {
//   List<PlanetList>? planets;
//   PlanetModel({this.planets});
//   factory PlanetModel.maptomodel(Map m) {
//     return PlanetModel(
//       planets: m["planets"] != null
//           ? List<PlanetList>.from(
//               m["planets"].map((e) => PlanetList.maptomodel(e)),
//             )
//           : [],
//     );
//   }
// }

class PlanetList {
  String? name, atmosphere, description, image;
  double? mass_kg, orbital_period_days, orbital_distance_au;
  int? order, diameter_km, moons;
  List<String>? moon_list;
  PlanetList(
      {this.name,
      this.description,
      this.atmosphere,
      this.mass_kg,
      this.moons,
      this.orbital_period_days,
      this.diameter_km,
      this.orbital_distance_au,
      this.order,
      this.image,
      this.moon_list});
  factory PlanetList.maptomodel(Map m) {
    return PlanetList(
        name: m["name"],
        description: m["description"],
        atmosphere: m["atmosphere"],
        diameter_km: m["diameter_km"],
        orbital_distance_au: m["orbital_distance_au"],
        order: m["order"],
        mass_kg: m["mass_kg"],
        moons: m["moons"],
        image: m["image"],
        orbital_period_days: m["orbital_period_days"],
        moon_list: List.from(m["moon_list"] ?? []));
  }
}
