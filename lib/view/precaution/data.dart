class PrecuationInfo {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final List<String> images;

  PrecuationInfo(
    this.position, {
    this.name,
    this.iconImage,
    this.description,
    this.images,
  });
}

List<PrecuationInfo> info = [
  PrecuationInfo(1,
      name: 'Protective Mask',
      iconImage: 'assets/prevention/mask.png',
      description:
          "Always remember to wear a protective mask when stepping out.",
      images: []),
  PrecuationInfo(2,
      name: 'Wash Hands',
      iconImage: 'assets/prevention/wash.png',
      description:
          "Wash your hands often with soap and water and for 20 seconds atleast."
      ),
  PrecuationInfo(3,
      name: 'Cover Cough',
      iconImage: 'assets/prevention/coughCover.png',
      description:
      "Wash your hands often with soap and water and for 20 seconds atleast.",
    images: []),
  PrecuationInfo(4,
      name: 'Sanitize Often',
      iconImage: 'assets/prevention/sanitizer.png',
      description:
      "Use alchohol based sanitizer if water and soap are unavailable.",
      images: []),
  PrecuationInfo(5,
      name: 'No Face Touching',
      iconImage: 'assets/prevention/touch.png',
      description:
      "Don't touch your eyes, nose or mouth often and with unwashed hands.",
      images: []),

];
