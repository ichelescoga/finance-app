import 'package:developer_company/data/repositories/loan_application_repository.dart';
import 'package:developer_company/data/providers/loan_application_provider.dart';
import 'package:developer_company/data/models/loan_application_model.dart';

class LoanApplicationRepositoryImpl implements LoanApplicationRepository {
  final LoanApplicationProvider loanApplicationProvider;

  LoanApplicationRepositoryImpl(this.loanApplicationProvider);

  @override
  Future<bool> submitLoanApplication(LoanApplication loanApplication) async {
    return await loanApplicationProvider.submitLoanApplication(loanApplication);
  }

  @override
  Future<bool> updateLoanApplication(LoanApplication loanApplication, String applicationId) async {
    return await loanApplicationProvider.updateLoanApplication(loanApplication, applicationId);
  }
    


  @override
  Future<LoanApplication?> fetchLoanApplication(String applicationId) async {
    return await loanApplicationProvider.fetchLoanApplication(applicationId);
  }
}