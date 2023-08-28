import 'package:walletapp/bar_graph/individual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<IndividualBar> barData = <IndividualBar>[];

  // initialize
  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: sunAmount.toInt()),
      IndividualBar(x: 1, y: monAmount.toInt()),
      IndividualBar(x: 2, y: tueAmount.toInt()),
      IndividualBar(x: 3, y: wedAmount.toInt()),
      IndividualBar(x: 4, y: thuAmount.toInt()),
      IndividualBar(x: 5, y: friAmount.toInt()),
      IndividualBar(x: 6, y: satAmount.toInt()),
    ];
  }
}
