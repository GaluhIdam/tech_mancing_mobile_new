class ResponseServiceDto {
  int statusCode;
  ResponseDTO response;

  ResponseServiceDto({
    required this.statusCode,
    required this.response,
  });

  factory ResponseServiceDto.fromJson(Map<String, dynamic> json) {
    final statusCode =
        json["statusCode"] ?? 500; // Default to 500 if statusCode is null
    final responseJson = json["response"];
    final response = responseJson != null
        ? ResponseDTO.fromJson(responseJson)
        : ResponseDTO(message: "", response: null, token: null);

    return ResponseServiceDto(
      statusCode: statusCode,
      response: response,
    );
  }
}

class ResponseDTO {
  String message;
  dynamic response;
  String? token;
  ResponseDTO({
    required this.message,
    required this.response,
    required this.token,
  });

  factory ResponseDTO.fromJson(Map<String, dynamic> json) => ResponseDTO(
        message: json["message"],
        response: json["data"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "response": response,
        "token": token,
      };
}
