import 'dart:convert';

class Actor {
  int id;
  String name;
  String overview;
  String profilePath;
  String bio;
  String knownForDep;
  String birthDay;
  double popularity;
  //Map knwownFor;
  Actor({
    required this.id,
    required this.name,
    required this.overview,
    required this.profilePath,
    required this.bio,
    required this.knownForDep,
    required this.birthDay,
    required this.popularity,
    //required this.knwownFor,
  });

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'] as int,
      name: map['name'] ?? '',
      overview: map['overview'] ?? '',
      profilePath: map['profile_path'] ?? '',
      bio: map['biography'] ?? '',
      knownForDep: map['known_for_department'] ?? '',
      birthDay: map['birthday'] ?? '',
      popularity: map['popularity'] ?? '',
      //knwownFor: map['knownFor'] ?? '',
    );
  }

  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));
}
