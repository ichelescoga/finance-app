import 'package:developer_company/data/models/loan_application_model.dart';

abstract class LoanApplicationRepository {
  Future<bool> submitLoanApplication(LoanApplication loanApplication);
  Future<LoanApplication?> fetchLoanApplication(String applicationId);
}
