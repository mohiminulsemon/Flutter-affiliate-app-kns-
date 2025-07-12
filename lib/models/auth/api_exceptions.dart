class ApiException implements Exception {
  final String message;
  final int? code;
  final List<Map<String, dynamic>>? errorSources;

  ApiException(this.message, {this.code, this.errorSources});

  factory ApiException.fromResponse(Map<String, dynamic> json) {
    String msg = json['message'] ?? 'Unknown error occurred';

    if (json['errorSources'] != null &&
        json['errorSources'] is List &&
        (json['errorSources'] as List).isNotEmpty) {
      final List errorList = json['errorSources'];
      msg = errorList
          .map((e) => (e['message'] ?? '').toString())
          .where((e) => e.isNotEmpty)
          .join('\n');
    }

    return ApiException(
      msg,
      code: json['statusCode'],
      errorSources: (json['errorSources'] as List?)
          ?.cast<Map<String, dynamic>>(),
    );
  }

  @override
  String toString() => message;
}
