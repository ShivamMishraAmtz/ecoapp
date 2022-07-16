class CompanyDataModal {
  final int id;
  final String company_name;
  final String mobile_number_first;
  final String mobile_number_second;
  final String email_id;
  final String company_address;
  final String company_logo;
  final String type;
  final String url;
  final String description;

  CompanyDataModal({
    required this.id,
    required this.company_name,
    required this.mobile_number_first,
    required this.mobile_number_second,
    required this.email_id,
    required this.company_address,
    required this.company_logo,
    required this.type,
    required this.url,
    required this.description,
  });

  factory CompanyDataModal.fromJson(Map json) {
    return CompanyDataModal(
      id: json['id'],
      company_name: json['company_name'],
      mobile_number_first: json['mobile_number_first'],
      mobile_number_second: json['mobile_number_second'],
      email_id: json['email_id'],
      company_address: json['company_address'],
      company_logo: json['company_logo'],
      type: json['type'],
      url: json['url'],
      description: json['description'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["company_name"] = company_name;
    map["mobile_number_first"] = mobile_number_first;
    map["mobile_number_second"] = mobile_number_second;
    map["email_id"] = email_id;
    map["company_address"] = company_address;
    map["company_logo"] = company_logo;
    map["type"] = type;
    map["url"] = url;
    map["description"] = description;
    return map;
  }
}
