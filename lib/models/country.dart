class Country {
  const Country({required this.name, required this.code, required this.states});

  factory Country.fromJson(Map json) {
    final _states = json['states'] == null
        ? null
        : (json['states'] as List)
            .map((e) => State.fromJson(e as Map))
            .toList();

    return Country(
      name: json['name'].toString(),
      code: json['code'].toString(),
      states: _states ?? [],
    );
  }

  final String name;
  final String code;
  final List<State> states;
}

class State {
  const State({
    required this.name,
    required this.code,
  });

  factory State.fromJson(Map json) {
    return State(
      name: json['name'].toString(),
      code: json['code'].toString(),
    );
  }

  final String name;
  final String code;
}
