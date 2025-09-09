class SearchLead {
  final String customerName;
  final String mobile;
  final String location;
  final String SearchLeadDate;
  final String apptime;
  final String pincode;
  final String offAddress;
  final String offPincode;
  final String resAddress;
  final String clientName;
  final String SearchLeadId;
  final String SearchLeadType;
  final String amzAppId;
  final String clientId;
  final String leadId;

  SearchLead({
    required this.customerName,
    required this.mobile,
    required this.location,
    required this.SearchLeadDate,
    required this.apptime,
    required this.pincode,
    required this.offAddress,
    required this.offPincode,
    required this.resAddress,
    required this.clientName,
    required this.SearchLeadId,
    required this.SearchLeadType,
    required this.amzAppId,
    required this.clientId,
    required this.leadId,
  });

  factory SearchLead.fromJson(Map<String, dynamic> json) {
    return SearchLead(
      customerName: json['customer_name'] ?? '',
      mobile: json['mobile'] ?? '',
      location: json['location'] ?? '',
      SearchLeadDate: json['SearchLead_date'] ?? '',
      apptime: json['apptime'] ?? '',
      pincode: json['pincode'] ?? '',
      offAddress: json['off_address'] ?? '',
      offPincode: json['off_pincode'] ?? '',
      resAddress: json['res_address'] ?? '',
      clientName: json['clientname'] ?? '',
      SearchLeadId: json['SearchLead_id'] ?? '',
      SearchLeadType: json['SearchLead_type'] ?? '',
      amzAppId: json['AMZAppId'] ?? '',
      clientId: json['client_id'] ?? '',
      leadId: json['lead_id'],
    );
  }
}
