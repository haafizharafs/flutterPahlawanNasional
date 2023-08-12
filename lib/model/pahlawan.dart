import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
    String name;
    dynamic birthYear;
    int deathYear;
    String description;
    int ascensionYear;

    Welcome({
        required this.name,
        required this.birthYear,
        required this.deathYear,
        required this.description,
        required this.ascensionYear,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        name: json["name"],
        birthYear: json["birth_year"],
        deathYear: json["death_year"],
        description: json["description"],
        ascensionYear: json["ascension_year"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "birth_year": birthYear,
        "death_year": deathYear,
        "description": description,
        "ascension_year": ascensionYear,
    };
}