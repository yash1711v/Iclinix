import 'dart:convert';

class SubscriptionModelHistory {
  final int subscriptionId;
  final String subscriptionUniqueId;
  final int patientId;
  final int userId;
  final int planId;
  final int subsHistoryId;
  final int status;
  final int expired;
  final String expiredAt;
  final String updatedAt;
  final String createdAt;
  final List<SubscriptionHistory> subscriptionHistory;

  SubscriptionModelHistory({
    required this.subscriptionId,
    required this.subscriptionUniqueId,
    required this.patientId,
    required this.userId,
    required this.planId,
    required this.subsHistoryId,
    required this.status,
    required this.expired,
    required this.expiredAt,
    required this.updatedAt,
    required this.createdAt,
    required this.subscriptionHistory,
  });

  factory SubscriptionModelHistory.fromJson(Map<String, dynamic> json) {
    return SubscriptionModelHistory(
      subscriptionId: json['subscription_id'],
      subscriptionUniqueId: json['subscription_unique_id'],
      patientId: json['patient_id'],
      userId: json['user_id'],
      planId: json['plan_id'],
      subsHistoryId: json['subs_history_id'],
      status: json['status'],
      expired: json['expired'],
      expiredAt: json['expired_at'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      subscriptionHistory: (json['subscription_history'] as List)
          .map((item) => SubscriptionHistory.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subscription_id': subscriptionId,
      'subscription_unique_id': subscriptionUniqueId,
      'patient_id': patientId,
      'user_id': userId,
      'plan_id': planId,
      'subs_history_id': subsHistoryId,
      'status': status,
      'expired': expired,
      'expired_at': expiredAt,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'subscription_history': subscriptionHistory.map((item) => item.toJson()).toList(),
    };
  }
}

class SubscriptionHistory {
  final int subsHistoryId;
  final int subscriptionId;
  final int planId;
  final int patientId;
  final int userId;
  final String planName;
  final String planDuration;
  final int planPrice;
  final int planDiscount;
  final String discountType;
  final int planSellPrice;
  final int status;
  final String approvedAt;
  final String? canceledAt;
  final String expiredAt;
  final String createdAt;
  final SubsTransaction subsTransaction;

  SubscriptionHistory({
    required this.subsHistoryId,
    required this.subscriptionId,
    required this.planId,
    required this.patientId,
    required this.userId,
    required this.planName,
    required this.planDuration,
    required this.planPrice,
    required this.planDiscount,
    required this.discountType,
    required this.planSellPrice,
    required this.status,
    required this.approvedAt,
    this.canceledAt,
    required this.expiredAt,
    required this.createdAt,
    required this.subsTransaction,
  });

  factory SubscriptionHistory.fromJson(Map<String, dynamic> json) {
    return SubscriptionHistory(
      subsHistoryId: json['subs_history_id'],
      subscriptionId: json['subscription_id'],
      planId: json['plan_id'],
      patientId: json['patient_id'],
      userId: json['user_id'],
      planName: json['plan_name'],
      planDuration: json['plan_duration'],
      planPrice: json['plan_price'],
      planDiscount: json['plan_discount'],
      discountType: json['discount_type'],
      planSellPrice: json['plan_sell_price'],
      status: json['status'],
      approvedAt: json['approved_at'],
      canceledAt: json['canceled_at'],
      expiredAt: json['expired_at'],
      createdAt: json['created_at'],
      subsTransaction: SubsTransaction.fromJson(json['subs_transaction']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subs_history_id': subsHistoryId,
      'subscription_id': subscriptionId,
      'plan_id': planId,
      'patient_id': patientId,
      'user_id': userId,
      'plan_name': planName,
      'plan_duration': planDuration,
      'plan_price': planPrice,
      'plan_discount': planDiscount,
      'discount_type': discountType,
      'plan_sell_price': planSellPrice,
      'status': status,
      'approved_at': approvedAt,
      'canceled_at': canceledAt,
      'expired_at': expiredAt,
      'created_at': createdAt,
      'subs_transaction': subsTransaction.toJson(),
    };
  }
}

class SubsTransaction {
  final int subsTxnId;
  final int subsHistoryId;
  final int subscriptionId;
  final String invoiceNo;
  final String paymentAmount;
  final String transactionNo;
  final String? paymentSubscriptionId;
  final String paymentMethod;
  final int paymentStatus;
  final String? paymentDetails;
  final String? paymentNote;
  final String approvedAt;
  final String createdAt;
  final String updatedAt;

  SubsTransaction({
    required this.subsTxnId,
    required this.subsHistoryId,
    required this.subscriptionId,
    required this.invoiceNo,
    required this.paymentAmount,
    required this.transactionNo,
    this.paymentSubscriptionId,
    required this.paymentMethod,
    required this.paymentStatus,
    this.paymentDetails,
    this.paymentNote,
    required this.approvedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubsTransaction.fromJson(Map<String, dynamic> json) {
    return SubsTransaction(
      subsTxnId: json['subs_txn_id'],
      subsHistoryId: json['subs_history_id'],
      subscriptionId: json['subscription_id'],
      invoiceNo: json['invoice_no'],
      paymentAmount: json['payment_amount'],
      transactionNo: json['transaction_no'],
      paymentSubscriptionId: json['payment_subscription_id'],
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
      paymentDetails: json['payment_details'],
      paymentNote: json['payment_note'],
      approvedAt: json['approved_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subs_txn_id': subsTxnId,
      'subs_history_id': subsHistoryId,
      'subscription_id': subscriptionId,
      'invoice_no': invoiceNo,
      'payment_amount': paymentAmount,
      'transaction_no': transactionNo,
      'payment_subscription_id': paymentSubscriptionId,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'payment_details': paymentDetails,
      'payment_note': paymentNote,
      'approved_at': approvedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
