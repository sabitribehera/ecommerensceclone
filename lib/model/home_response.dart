class HomeResponse {
  List<String>? webPages;
  String? name;
  List<String>? domains;
  String? country;
  String? stateProvince;
  String? alphaTwoCode;

  HomeResponse(
      {this.webPages,
        this.name,
        this.domains,
        this.country,
        this.stateProvince,
        this.alphaTwoCode});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    webPages = json['web_pages']== null? []: json['web_pages'].cast<String>();
    name = json['name']??"_";
    domains = json['domains'] == null? []: json['domains'].cast<String>();
    country = json['country']??"_";
    stateProvince = json['state-province']??"_";
    alphaTwoCode = json['alpha_two_code']??"_";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['web_pages'] = this.webPages;
    data['name'] = this.name;
    data['domains'] = this.domains;
    data['country'] = this.country;
    data['state-province'] = this.stateProvince;
    data['alpha_two_code'] = this.alphaTwoCode;
    return data;
  }
}
