import 'package:developer_company/data/models/credits_approved_reserved_model.dart';
import 'package:developer_company/data/providers/credits_approved_reserved_provider.dart';
import 'package:developer_company/data/repositories/credits_approved_reserved_repository.dart';

class CreditsApprovedReservedImpl implements CreditsApprovedReservedRepository {
  final CreditsApprovedReservedProvider creditApproveReserved;

  CreditsApprovedReservedImpl(this.creditApproveReserved);

  @override
  Future<List<CreditsApprovedReserved>> fetchCreditsApprovedReserved() async {
    return await creditApproveReserved.fetchCreditsApprovedReserved();
  }
}
