import 'package:flutter/foundation.dart';

class PhaseMember {
  final String fullName;
  final String? image; // Image might be null
  final String user;

  const PhaseMember({
    required this.fullName,
    this.image,
    required this.user,
  });

  factory PhaseMember.fromJson(Map<String, dynamic> json) {
    return PhaseMember(
      fullName: json['fullName'] as String? ?? 'Unknown Name',
      image: json['image'] as String?,
      user: json['user'] as String? ?? 'Unknown User',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'image': image,
      'user': user,
    };
  }

  PhaseMember copyWith({
    String? fullName,
    String? image,
    String? user,
  }) {
    return PhaseMember(
      fullName: fullName ?? this.fullName,
      image: image ?? this.image,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'PhaseMember(fullName: $fullName, image: $image, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhaseMember &&
        other.fullName == fullName &&
        other.image == image &&
        other.user == user;
  }

  @override
  int get hashCode => fullName.hashCode ^ image.hashCode ^ user.hashCode;
}



class Phase {
  final String id;
  final String status;
  final String name;
  final int budget;
  final List<PhaseMember> members;
  final DateTime? deadline; // Nullable DateTime

  const Phase({
    required this.id,
    required this.status,
    required this.name,
    required this.budget,
    required this.members,
    this.deadline,
  });

  factory Phase.fromJson(Map<String, dynamic> json) {
    List<PhaseMember> parsedMembers = [];
    if (json['members'] != null && json['members'] is List) {
      parsedMembers = (json['members'] as List)
          .map((memberJson) => PhaseMember.fromJson(memberJson as Map<String, dynamic>))
          .toList();
    }

    DateTime? parsedDeadline;
    if (json['deadline'] != null) {
        // Use tryParse for safety
        parsedDeadline = DateTime.tryParse(json['deadline'] as String);
    }


    return Phase(
      id: json['_id'] as String? ?? 'Unknown ID', // Map _id to id
      status: json['status'] as String? ?? 'UNKNOWN',
      name: json['name'] as String? ?? 'Unknown Phase',
      budget: (json['budget'] as num?)?.toInt() ?? 0,
      members: parsedMembers,
      deadline: parsedDeadline,
    );
  }

   Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'status': status,
      'name': name,
      'budget': budget,
      'members': members.map((m) => m.toJson()).toList(),
      'deadline': deadline?.toIso8601String(),
    };
  }

  Phase copyWith({
    String? id,
    String? status,
    String? name,
    int? budget,
    List<PhaseMember>? members,
    DateTime? deadline, // Allow setting deadline to null explicitly if needed
    bool setDeadlineToNull = false, // Helper to explicitly set to null
  }) {
    return Phase(
      id: id ?? this.id,
      status: status ?? this.status,
      name: name ?? this.name,
      budget: budget ?? this.budget,
      members: members ?? this.members,
      deadline: setDeadlineToNull ? null : (deadline ?? this.deadline),
    );
  }

  @override
  String toString() {
    return 'Phase(id: $id, status: $status, name: $name, budget: $budget, members: $members, deadline: $deadline)';
  }

    @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    // Using listEquals from foundation.dart for list comparison
    // import 'package:flutter/foundation.dart';

    return other is Phase &&
        other.id == id &&
        other.status == status &&
        other.name == name &&
        other.budget == budget &&
        listEquals(other.members, members) && // Correct list comparison
        other.deadline == deadline;
  }

  @override
  int get hashCode {
      // Using Object.hash for combining hash codes
      return Object.hash(
          id,
          status,
          name,
          budget,
          Object.hashAll(members), // Correct way to hash list items
          deadline);
  }
}



class AssignedMember {
  final String user; // user ID is likely the primary identifier
  final String fullName;
  final String? position; // Might be null or empty
  final String? email;
  final String? phone;
  final String? image;

  const AssignedMember({
    required this.user,
    required this.fullName,
    this.position,
    this.email,
    this.phone,
    this.image,
  });

  factory AssignedMember.fromJson(Map<String, dynamic> json) {
    return AssignedMember(
      user: json['user'] as String? ?? 'Unknown User ID', // Map user field
      fullName: json['fullName'] as String? ?? 'Unknown Name',
      position: json['position'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'fullName': fullName,
      'position': position,
      'email': email,
      'phone': phone,
      'image': image,
    };
  }

  AssignedMember copyWith({
    String? user,
    String? fullName,
    String? position,
    String? email,
    String? phone,
    String? image,
  }) {
    return AssignedMember(
      user: user ?? this.user,
      fullName: fullName ?? this.fullName,
      position: position ?? this.position,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'AssignedMember(user: $user, fullName: $fullName, position: $position, email: $email, phone: $phone, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssignedMember &&
        other.user == user &&
        other.fullName == fullName &&
        other.position == position &&
        other.email == email &&
        other.phone == phone &&
        other.image == image;
  }

  @override
  int get hashCode {
    // Using Object.hash for combining hash codes
    return Object.hash(user, fullName, position, email, phone, image);
  }
}





class Project {
  final String id; // Renamed from _id
  final String name;
  final String? clientName; // Made nullable as it could potentially be null
  final String? projectGroup; // Nullable
  final String? googleSheetLink; // Nullable
  final String? teamId; // Nullable
  final List<AssignedMember> assignedMembers;
  final List<Phase> phases;
  final int? totalBudget; // Made nullable, seems calculated/derived, might be absent
  final int? duration; // Made nullable
  final DateTime? lastUpdate; // Nullable DateTime
  final String? description;
  final String? salesName;
  final String status;
  final bool isDeleted;
  final DateTime createdAt; // Non-nullable DateTime
  final DateTime updatedAt; // Non-nullable DateTime
  final int? v; // Renamed from __v, made nullable

  const Project({
    required this.id,
    required this.name,
    this.clientName,
    this.projectGroup,
    this.googleSheetLink,
    this.teamId,
    required this.assignedMembers,
    required this.phases,
    this.totalBudget,
    this.duration,
    this.lastUpdate,
    this.description,
    this.salesName,
    required this.status,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.v,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    // Helper function for safe DateTime parsing
    DateTime? tryParseDateTime(String? dateString) {
      if (dateString == null) return null;
      return DateTime.tryParse(dateString);
    }
     // Helper function for required DateTime parsing (throws if invalid)
    DateTime parseRequiredDateTime(String? dateString, String fieldName) {
      if (dateString == null) {
         throw FormatException("Missing required DateTime field: $fieldName");
      }
      try {
        return DateTime.parse(dateString);
      } catch (e) {
         throw FormatException("Invalid format for DateTime field: $fieldName", dateString);
      }
    }


    List<AssignedMember> parsedAssignedMembers = [];
    if (json['assignedMembers'] != null && json['assignedMembers'] is List) {
      parsedAssignedMembers = (json['assignedMembers'] as List)
          .map((memberJson) => AssignedMember.fromJson(memberJson as Map<String, dynamic>))
          .toList();
    }

    List<Phase> parsedPhases = [];
    if (json['phases'] != null && json['phases'] is List) {
      parsedPhases = (json['phases'] as List)
          .map((phaseJson) => Phase.fromJson(phaseJson as Map<String, dynamic>))
          .toList();
    }

    return Project(
      id: json['_id'] as String? ?? 'Unknown Project ID',
      name: json['name'] as String? ?? 'Unnamed Project',
      clientName: json['clientName'] as String?,
      projectGroup: json['projectGroup'] as String?,
      googleSheetLink: json['googleSheetLink'] as String?,
      teamId: json['teamId'] as String?,
      assignedMembers: parsedAssignedMembers,
      phases: parsedPhases,
      totalBudget: (json['totalBudget'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      lastUpdate: tryParseDateTime(json['lastUpdate'] as String?),
      description: json['description'] as String?,
      salesName: json['salesName'] as String?,
      status: json['status'] as String? ?? 'UNKNOWN',
      isDeleted: json['isDeleted'] as bool? ?? false,
      createdAt: parseRequiredDateTime(json['createdAt'] as String?, 'createdAt'),
      updatedAt: parseRequiredDateTime(json['updatedAt'] as String?, 'updatedAt'),
      v: (json['__v'] as num?)?.toInt(),
    );
  }

   Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'clientName': clientName,
      'projectGroup': projectGroup,
      'googleSheetLink': googleSheetLink,
      'teamId': teamId,
      'assignedMembers': assignedMembers.map((m) => m.toJson()).toList(),
      'phases': phases.map((p) => p.toJson()).toList(),
      'totalBudget': totalBudget,
      'duration': duration,
      'lastUpdate': lastUpdate?.toIso8601String(),
      'description': description,
      'salesName': salesName,
      'status': status,
      'isDeleted': isDeleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }


  Project copyWith({
    String? id,
    String? name,
    String? clientName,
    String? projectGroup, // Allow explicit null setting if needed
    bool setProjectGroupToNull = false,
    String? googleSheetLink,
    bool setGoogleSheetLinkToNull = false,
    String? teamId,
    bool setTeamIdToNull = false,
    List<AssignedMember>? assignedMembers,
    List<Phase>? phases,
    int? totalBudget,
    bool setTotalBudgetToNull = false,
    int? duration,
     bool setDurationToNull = false,
    DateTime? lastUpdate,
    bool setLastUpdateToNull = false,
    String? description,
    String? salesName,
    String? status,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    bool setVToNull = false,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      clientName: clientName ?? this.clientName,
      projectGroup: setProjectGroupToNull ? null : (projectGroup ?? this.projectGroup),
      googleSheetLink: setGoogleSheetLinkToNull ? null : (googleSheetLink ?? this.googleSheetLink),
      teamId: setTeamIdToNull ? null : (teamId ?? this.teamId),
      assignedMembers: assignedMembers ?? this.assignedMembers,
      phases: phases ?? this.phases,
      totalBudget: setTotalBudgetToNull ? null : (totalBudget ?? this.totalBudget),
      duration: setDurationToNull ? null : (duration ?? this.duration),
      lastUpdate: setLastUpdateToNull ? null : (lastUpdate ?? this.lastUpdate),
      description: description ?? this.description,
      salesName: salesName ?? this.salesName,
      status: status ?? this.status,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: setVToNull ? null : (v ?? this.v),
    );
  }

  @override
  String toString() {
    return 'Project(id: $id, name: $name, clientName: $clientName, projectGroup: $projectGroup, googleSheetLink: $googleSheetLink, teamId: $teamId, assignedMembers: $assignedMembers, phases: $phases, totalBudget: $totalBudget, duration: $duration, lastUpdate: $lastUpdate, description: $description, salesName: $salesName, status: $status, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
     // Use listEquals from foundation.dart for list comparison
    // import 'package:flutter/foundation.dart';

    return other is Project &&
        other.id == id &&
        other.name == name &&
        other.clientName == clientName &&
        other.projectGroup == projectGroup &&
        other.googleSheetLink == googleSheetLink &&
        other.teamId == teamId &&
        listEquals(other.assignedMembers, assignedMembers) && // Correct
        listEquals(other.phases, phases) && // Correct
        other.totalBudget == totalBudget &&
        other.duration == duration &&
        other.lastUpdate == lastUpdate &&
        other.description == description &&
        other.salesName == salesName &&
        other.status == status &&
        other.isDeleted == isDeleted &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.v == v;
  }

  @override
  int get hashCode {
      // Using Object.hash for combining hash codes
      return Object.hash(
          id,
          name,
          clientName,
          projectGroup,
          googleSheetLink,
          teamId,
          Object.hashAll(assignedMembers), // Correct way to hash lists
          Object.hashAll(phases),         // Correct way to hash lists
          totalBudget,
          duration,
          lastUpdate,
          description,
          salesName,
          status,
          isDeleted,
          createdAt,
          updatedAt,
          v);
  }
}