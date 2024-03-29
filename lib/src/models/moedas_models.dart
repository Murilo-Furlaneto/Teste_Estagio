class MoedasModels {
  String currency;
  double rate;

  MoedasModels({
    required this.currency,
    required this.rate,
  });

  factory MoedasModels.fromJson(Map<String, dynamic> json) {
    return MoedasModels(
      currency: json.keys.first,
      rate: json.values.first.toDouble(),
    );
  }
}
