class SelfLeadAlloterModel {
  final String leadId;
  final String customerName;
  final String mobile;
  final String statusId;
  final String clientId;
  final String branchId;

  SelfLeadAlloterModel({
    required this.leadId,
    required this.customerName,
    required this.mobile,
    required this.statusId,
    required this.clientId,
    required this.branchId,
  });

  factory SelfLeadAlloterModel.fromJson(Map<String, dynamic> json) {
    return SelfLeadAlloterModel(
      leadId: json['leadId'] ?? '',
      customerName: json['customer_name'] ?? '',
      mobile: json['mobile'] ?? '',
      statusId: json['status_id'] ?? '',
      clientId: json['client_id'] ?? '',
      branchId: json['branch_id'] ?? '',
    );
  }
}
