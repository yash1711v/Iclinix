class Ticket {
  final int? id;
  final String? ticketNo;
  final int? userId;
  final String? subject;
  final String? status;
  final String? priority;
  final int? typeId;
  final DateTime? closeDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<TicketReply>? ticketToReplies;
  final TicketType? ticketType;

  Ticket({
    this.id,
    this.ticketNo,
    this.userId,
    this.subject,
    this.status,
    this.priority,
    this.typeId,
    this.closeDate,
    this.createdAt,
    this.updatedAt,
    this.ticketToReplies,
    this.ticketType,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      ticketNo: json['ticket_no'],
      userId: json['user_id'],
      subject: json['subject'],
      status: json['status'],
      priority: json['priority'],
      typeId: json['type_id'],
      closeDate: json['close_date'] != null ? DateTime.tryParse(json['close_date']) : null,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
      ticketToReplies: (json['ticket_to_replies'] as List<dynamic>?)
          ?.map((e) => TicketReply.fromJson(e))
          .toList(),
      ticketType: json['ticket_type'] != null
          ? TicketType.fromJson(json['ticket_type'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticket_no': ticketNo,
      'user_id': userId,
      'subject': subject,
      'status': status,
      'priority': priority,
      'type_id': typeId,
      'close_date': closeDate?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'ticket_to_replies': ticketToReplies?.map((e) => e.toJson()).toList(),
      'ticket_type': ticketType?.toJson(),
    };
  }
}

class TicketReply {
  final int? id;
  final int? ticketId;
  final int? replyBy;
  final int? replyByUserId;
  final String? message;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  TicketReply({
    this.id,
    this.ticketId,
    this.replyBy,
    this.replyByUserId,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory TicketReply.fromJson(Map<String, dynamic> json) {
    return TicketReply(
      id: json['id'],
      ticketId: json['ticket_id'],
      replyBy: json['reply_by'],
      replyByUserId: json['reply_by_user_id'],
      message: json['message'],
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
      deletedAt: json['deleted_at'] != null ? DateTime.tryParse(json['deleted_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticket_id': ticketId,
      'reply_by': replyBy,
      'reply_by_user_id': replyByUserId,
      'message': message,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}

class TicketType {
  final int? id;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TicketType({
    this.id,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory TicketType.fromJson(Map<String, dynamic> json) {
    return TicketType(
      id: json['id'],
      type: json['type'],
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
