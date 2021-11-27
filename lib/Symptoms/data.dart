class SymptomsInfo {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final List<String> images;

  SymptomsInfo(
    this.position, {
    this.name,
    this.iconImage,
    this.description,
    this.images,
  });
}

List<SymptomsInfo> info = [
  SymptomsInfo(1,
      name: 'Fever',
      iconImage: 'assets/symptoms/high_fever.png',
      description:
      "A temperature that's higher than normal.\nTypically around 98.6°F (37°C)",
      images: [

      ]),
  SymptomsInfo(2,
      name: 'Sore Throat',
      iconImage: 'assets/symptoms/sore_throat.png',
      description:
      "A sore throat is a painful, dry, or scratchy feeling in the throat.",
      ),
  SymptomsInfo(3,
      name: 'Dry Cough',
      iconImage: 'assets/symptoms/cough.png',
      description:
      "A cough that doesn't bring up mucus.",
      images: []),
  SymptomsInfo(4,
      name: 'Fatigue',
      iconImage: 'assets/symptoms/headache.png',
      description:
      "You have no energy, no motivation and overall feeling of tiredeness.",
      images: []),
  SymptomsInfo(5,
      name: 'Runny Nose',
      iconImage: 'assets/symptoms/high_fever.png',
      description:
      "Mucus draining or dripping from the nostril.",
      images: []),
  SymptomsInfo(6,
      name: 'Tough Breathing',
      iconImage: 'assets/symptoms/sore_throat.png',
      description:
      "You feel shortness of breath and a tight sensation in your chest",
      images: []),

];
