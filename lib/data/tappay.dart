class Prime {
  String? status;
  String? message;
  String? prime;

  Prime({this.status, this.message, this.prime});

  factory Prime.fromJson(Map<String, dynamic> json) {
    return Prime(
      status: json['status'],
      message: json['message'],
      prime: json['prime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'prime': prime,
    };
  }
}