class Booking {
  final int id;
  final int subSubcategoryId;
  final int userId;
  final double amountWithoutGst;
  final double amountWithGst;
  final String selectedDate;
  final String selectedTime;
  final String mobileNo;
  int serviceId;
  int status;

  Booking({
    required this.id,
    required this.subSubcategoryId,
    required this.userId,
    required this.amountWithoutGst,
    required this.amountWithGst,
    required this.selectedDate,
    required this.selectedTime,
    required this.mobileNo,
    required this.status,
    this.serviceId = 0,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      subSubcategoryId: json['sub_subcategory_id'],
      userId: json['user_id'],
      amountWithoutGst: (json['amount_without_gst'] as num).toDouble(),
      amountWithGst: (json['amount_with_gst'] as num).toDouble(),
      selectedDate: json['selected_date'],
      selectedTime: json['selected_time'],
      mobileNo: json['mobile_no'],
      status: json['status'],
      serviceId: json['service_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sub_subcategory_id': subSubcategoryId,
      'user_id': userId,
      'amount_without_gst': amountWithoutGst,
      'amount_with_gst': amountWithGst,
      'selected_date': selectedDate,
      'selected_time': selectedTime,
      'mobile_no': mobileNo,
      'status': status,
    };
  }
}
