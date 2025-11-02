import '../models/policy.dart';

class PolicyService {
  static final PolicyService _instance = PolicyService._internal();
  factory PolicyService() => _instance;
  PolicyService._internal();

  // 샘플 데이터
  List<Policy> _samplePolicies = [
    Policy(
      id: '1',
      plcyNm: '대학생 창업지원 프로그램',
      bscPlanPlcyWayNoNm: '창업지원',
      plcyExplnCn: '대학생을 위한 창업 지원 정책입니다.',
      rgtrupInstCdNm: '서울',
      aplyPrdSeCd: '상시',
      aplyPrdEndYmd: '20241231',
      applicationUrl: 'https://example.com',
      requirements: ['대학생', '사업계획서'],
      saves: 324,
    ),
    Policy(
      id: '2',
      plcyNm: '국가우수장학금',
      bscPlanPlcyWayNoNm: '장학금',
      plcyExplnCn: '성적우수 학생을 위한 장학금입니다.',
      rgtrupInstCdNm: '전국',
      aplyPrdSeCd: '2024.03.01~2024.05.31',
      aplyPrdEndYmd: '20240531',
      applicationUrl: 'https://example.com',
      requirements: ['성적 3.5 이상', '소득분위 8분위 이하'],
      saves: 567,
    ),
    Policy(
      id: '3',
      plcyNm: '청년 주거지원 프로그램',
      bscPlanPlcyWayNoNm: '주거지원',
      plcyExplnCn: '청년층을 위한 주거비 지원 정책입니다.',
      rgtrupInstCdNm: '서울',
      aplyPrdSeCd: '2024.01.01~2024.12.31',
      aplyPrdEndYmd: '20241231',
      applicationUrl: 'https://example.com',
      requirements: ['만 19-39세', '소득 요건 충족'],
      saves: 789,
    ),
  ];

  Future<List<Policy>> getRecommendedPolicies({
    List<String> interests = const [],
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    
    // 관심사에 따른 필터링 로직
    if (interests.isEmpty) return _samplePolicies.take(2).toList();
    
    return _samplePolicies.where((policy) {
      return interests.any((interest) => 
        policy.category.contains(interest) || 
        policy.title.contains(interest));
    }).take(2).toList();
  }

  Future<List<Policy>> getPopularPolicies() async {
    await Future.delayed(Duration(milliseconds: 300));
    
    // 저장 수로 정렬
    List<Policy> sorted = List.from(_samplePolicies);
    sorted.sort((a, b) => b.saves.compareTo(a.saves));
    
    return sorted.take(3).toList();
  }

  Future<List<Policy>> getUpcomingDeadlines() async {
    await Future.delayed(Duration(milliseconds: 300));
    
    // 마감일이 가까운 순으로 정렬
    List<Policy> sorted = List.from(_samplePolicies);
    sorted.sort((a, b) => (a.aplyPrdEndYmd ?? '').compareTo(b.aplyPrdEndYmd ?? ''));
    
    return sorted.take(3).toList();
  }

  Future<List<Policy>> searchPolicies(String query) async {
    await Future.delayed(Duration(milliseconds: 500));
    
    if (query.isEmpty) return _samplePolicies;
    
    return _samplePolicies.where((policy) {
      return policy.plcyNm.toLowerCase().contains(query.toLowerCase()) ||
             policy.bscPlanPlcyWayNoNm.toLowerCase().contains(query.toLowerCase()) ||
             policy.plcyExplnCn.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Future<bool> bookmarkPolicy(String policyId) async {
    await Future.delayed(Duration(milliseconds: 200));
    // TODO: 실제 북마크 저장 로직
    return true;
  }

  Future<bool> unbookmarkPolicy(String policyId) async {
    await Future.delayed(Duration(milliseconds: 200));
    // TODO: 실제 북마크 해제 로직
    return true;
  }
}
