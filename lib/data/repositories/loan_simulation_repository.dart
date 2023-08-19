import 'package:developer_company/data/models/loan_simulation_model.dart';

abstract class LoanSimulationRepository {
  Future<List<LoanSimulationResponse?>> simulateLoan(
      LoanSimulationRequest request);
}
