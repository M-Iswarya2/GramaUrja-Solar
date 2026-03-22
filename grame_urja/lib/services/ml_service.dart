class MLService {
  // Simulated trained linear model: size = 0.5 + 0.1 * usage
  final double intercept = 0.5;
  final double coefficient = 0.1;

  String predictSolarSystem(double usage) {
    if (usage <= 0) return "⚠️ Please enter a valid usage (greater than 0).";

    double predictedSize = intercept + coefficient * usage;

    String recommended;
    if (predictedSize <= 1.5) {
      recommended = "1kW System 🔋 (suits very low consumption)";
    } else if (predictedSize <= 3.5) {
      recommended = "2–3kW System 🔋 (for small-medium homes)";
    } else if (predictedSize <= 5.5) {
      recommended = "4–5kW System 🔋 (for large homes)";
    } else {
      recommended = "5kW+ System 🔋 (for high usage or appliances)";
    }

    return "📊 Estimated need: ${predictedSize.toStringAsFixed(2)} kW\n✅ Recommendation: $recommended";
  }
}
