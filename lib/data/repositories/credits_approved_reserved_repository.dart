import 'package:developer_company/data/models/credits_approved_reserved_model.dart';

abstract class CreditsApprovedReservedRepository {
  Future<List<CreditsApprovedReserved>> fetchCreditsApprovedReserved();
}
