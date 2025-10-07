import 'dart:convert';

class BalancesModel {
  BalancesModel({
    required this.totalIncome,
    required this.totalOutcome,
    required this.totalBalance,
  });

  final double totalIncome;
  final double totalOutcome;
  final double totalBalance;

  BalancesModel copyWith({
    double? totalIncome,
    double? totalOutcome,
    double? totalBalance,
  }) {
    return BalancesModel(
      totalIncome: totalIncome ?? this.totalIncome,
      totalOutcome: totalOutcome ?? this.totalOutcome,
      totalBalance: totalBalance ?? this.totalBalance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalIncome': totalIncome,
      'totalOutcome': totalOutcome,
      'totalBalance': totalBalance,
    };
  }

  const BalancesModel.empty()
      : totalIncome = 0,
        totalOutcome = 0,
        totalBalance = 0;

  factory BalancesModel.fromMap(Map<String, dynamic> map) {
    return BalancesModel(
      totalIncome: double.tryParse(map['totalIncome']['aggregate']['sum']['value'].toString()) ?? 0,
      totalOutcome: double.tryParse(map['totalOutcome']['aggregate']['sum']['value'].toString()) ?? 0,
      totalBalance: double.tryParse(map['totalBalance']['aggregate']['sum']['value'].toString()) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BalancesModel.fromJson(String source) =>
      BalancesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BalancesModel(totalIncome: $totalIncome, totalOutcome: $totalOutcome, totalBalance: $totalBalance)';

  @override
  bool operator ==(covariant BalancesModel other) {
    if (identical(this, other)) return true;

    return other.totalIncome == totalIncome &&
        other.totalOutcome == totalOutcome &&
        other.totalBalance == totalBalance;
  }

  @override
  int get hashCode =>
      totalIncome.hashCode ^ totalOutcome.hashCode ^ totalBalance.hashCode;
}
