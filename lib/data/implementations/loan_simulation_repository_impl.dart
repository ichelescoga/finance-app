import 'package:developer_company/data/models/loan_simulation_model.dart';
import 'package:developer_company/data/providers/loan_simulation_provider.dart';
import 'package:developer_company/data/repositories/loan_simulation_repository.dart';

class LoanSimulationRepositoryImpl implements LoanSimulationRepository {
  final LoanSimulationProvider loanSimulationProvider;

  LoanSimulationRepositoryImpl(this.loanSimulationProvider);

  @override
  Future<List<LoanSimulationResponse?>> simulateLoan(
      LoanSimulationRequest request) async {
    return await loanSimulationProvider.simulateLoan(request);
  }
}
