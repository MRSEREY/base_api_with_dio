class UrlBuildService {
  final String objectUrlName;
  String apiPath = '/internal/partner';

  UrlBuildService(this.objectUrlName);

  fetchAllUrl() {
    return "$apiPath/${this.objectUrlName}";
  }
}
