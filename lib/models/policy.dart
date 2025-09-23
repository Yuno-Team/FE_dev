class Policy {
  final String id;
  final String plcyNm; // 정책명
  final String bscPlanPlcyWayNoNm; // 대분류
  final String plcyExplnCn; // 정책 설명
  final String rgtrupInstCdNm; // 지역
  final String aplyPrdSeCd; // 정책기간 상시여부
  final String? aplyPrdEndYmd; // 신청 마감 기한 YYYYMMDD
  final String applicationUrl;
  final List<String> requirements;
  final int saves;
  final bool isBookmarked;

  Policy({
    required this.id,
    required this.plcyNm,
    required this.bscPlanPlcyWayNoNm,
    required this.plcyExplnCn,
    required this.rgtrupInstCdNm,
    required this.aplyPrdSeCd,
    this.aplyPrdEndYmd,
    required this.applicationUrl,
    required this.requirements,
    this.saves = 0,
    this.isBookmarked = false,
  });

  factory Policy.fromJson(Map<String, dynamic> json) {
    return Policy(
      id: json['id'] ?? '',
      plcyNm: json['plcyNm'] ?? '',
      bscPlanPlcyWayNoNm: json['bscPlanPlcyWayNoNm'] ?? '',
      plcyExplnCn: json['plcyExplnCn'] ?? '',
      rgtrupInstCdNm: json['rgtrupInstCdNm'] ?? '',
      aplyPrdSeCd: json['aplyPrdSeCd'] ?? '',
      aplyPrdEndYmd: json['aplyPrdEndYmd'],
      applicationUrl: json['applicationUrl'] ?? '',
      requirements: List<String>.from(json['requirements'] ?? []),
      saves: json['saves'] ?? 0,
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plcyNm': plcyNm,
      'bscPlanPlcyWayNoNm': bscPlanPlcyWayNoNm,
      'plcyExplnCn': plcyExplnCn,
      'rgtrupInstCdNm': rgtrupInstCdNm,
      'aplyPrdSeCd': aplyPrdSeCd,
      'aplyPrdEndYmd': aplyPrdEndYmd,
      'applicationUrl': applicationUrl,
      'requirements': requirements,
      'saves': saves,
      'isBookmarked': isBookmarked,
    };
  }

  // Helper getters for backward compatibility and convenience
  String get title => plcyNm;
  String get category => bscPlanPlcyWayNoNm;
  String get description => plcyExplnCn;
  String get region => rgtrupInstCdNm;
  
  String get deadlineDisplay {
    if (aplyPrdSeCd == '상시') {
      return '상시';
    } else if (aplyPrdEndYmd != null) {
      // YYYYMMDD 형식을 파싱하여 D-Day 계산
      try {
        final endDate = DateTime.parse(aplyPrdEndYmd!);
        final now = DateTime.now();
        final difference = endDate.difference(now).inDays;
        return difference > 0 ? '신청마감 D-$difference' : '마감';
      } catch (e) {
        return aplyPrdSeCd;
      }
    }
    return aplyPrdSeCd;
  }
}
