import 'package:flutter/material.dart';
import 'policy_ai_summary_screen.dart';
import '../services/policy_service.dart';
import '../models/policy.dart';

class PolicyDetailScreen extends StatefulWidget {
  final String policyId;

  const PolicyDetailScreen({
    Key? key,
    required this.policyId,
  }) : super(key: key);

  @override
  _PolicyDetailScreenState createState() => _PolicyDetailScreenState();
}

class _PolicyDetailScreenState extends State<PolicyDetailScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoadingAiSummary = false;
  String? _aiSummaryResult;
  late AnimationController _loadingController;
  bool _isSaved = false; // 저장 상태
  
  Policy? _policy; // 정책 정보
  bool _isLoading = true; // 정책 로딩 상태
  final PolicyService _policyService = PolicyService();

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _loadPolicy();
  }

  Future<void> _loadPolicy() async {
    try {
      // policyId를 사용해서 정책 정보 로드
      final policies = await _policyService.searchPolicies('');
      final policy = policies.firstWhere(
        (p) => p.id == widget.policyId,
        orElse: () => policies.first, // 정책을 찾지 못하면 첫 번째 정책 사용
      );
      
      setState(() {
        _policy = policy;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  Future<void> _generateAiSummary() async {
    setState(() {
      _isLoadingAiSummary = true;
      _aiSummaryResult = null;
    });

    _loadingController.repeat();

    // 2초 로딩 시뮬레이션 (실제로는 API 호출)
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoadingAiSummary = false;
      _aiSummaryResult = '이 정책은 청년의 사회진출 지원을 위한 정책이야. 너의 프로필(만 25세, 서울 거주, 미취업자)을 기반으로 분석해보니 딱 맞는 정책이야! 신청하면 좋을 것 같아!';
    });

    _loadingController.stop();
    _loadingController.reset();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Color(0xFF111317),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF1447E6),
          ),
        ),
      );
    }

    if (_policy == null) {
      return Scaffold(
        backgroundColor: Color(0xFF111317),
        body: Center(
          child: Text(
            '정책을 찾을 수 없습니다.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF111317),
      body: SafeArea(
        child: Column(
          children: [
            // 상태 표시줄 영역
            Container(
              height: 32,
              color: Colors.transparent,
            ),
            
            // 헤더
            Container(
              height: 64,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Color(0xFFBDC4D0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    
                    // 정책 번호
                    Text(
                      '정책번호  ${widget.policyId}',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4B515D),
                        letterSpacing: -0.6,
                        height: 14/12,
                      ),
                    ),
                    SizedBox(height: 8),
                    
                    // 카테고리와 지역 태그
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFF162455),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _policy!.bscPlanPlcyWayNoNm,
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2C7FFF),
                              letterSpacing: -0.7,
                              height: 16/14,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFF002D21),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _policy!.rgtrupInstCdNm,
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF00D492),
                              letterSpacing: -0.7,
                              height: 16/14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    
                    // 정책명과 설명
                    Text(
                      _policy!.plcyNm,
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF6F8FA),
                        letterSpacing: -1.2,
                        height: 28/24,
                      ),
                    ),
                    SizedBox(height: 16),
                    
                    Text(
                      _policy!.plcyExplnCn,
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFBDC4D0),
                        letterSpacing: -0.7,
                        height: 16/14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16),
                    
                    // AI 요약 버튼/결과
                    _aiSummaryResult != null
                        ? Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF1E766F),
                                  Color(0xFF411F86),
                                  Color(0xFF750649),
                                ],
                                stops: [0.0, 0.54, 1.0],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AI 요약',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFBDC4D0),
                                    letterSpacing: -0.8,
                                    height: 18/16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  _aiSummaryResult!,
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFF6F8FA),
                                    letterSpacing: -0.7,
                                    height: 16/14,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF1E766F),
                                  Color(0xFF411F86),
                                  Color(0xFF750649),
                                ],
                                stops: [0.0, 0.54, 1.0],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ElevatedButton(
                              onPressed: _isLoadingAiSummary ? null : _generateAiSummary,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _isLoadingAiSummary
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: RotationTransition(
                                            turns: _loadingController,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          'AI 분석 중...',
                                          style: TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            letterSpacing: -1.0,
                                            height: 24/20,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'AI 요약',
                                      style: TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        letterSpacing: -1.0,
                                        height: 24/20,
                                      ),
                                    ),
                            ),
                          ),
                    SizedBox(height: 24),
                    
                    // 지원내용
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFF252931),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '지원내용',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFF6F8FA),
                              letterSpacing: -0.8,
                              height: 18/16,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            _getSupportContent(),
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFBDC4D0),
                              letterSpacing: -0.7,
                              height: 16/14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    
                    // 신청자격
                    _buildSection('신청자격', [
                      _buildInfoRow('연령', '만 19세~만 39세'),
                      _buildInfoRow('거주지역', _getRegionDetails()),
                    ]),
                    SizedBox(height: 32),
                    
                    // 신청방법
                    _buildSection('신청방법', [
                      _buildInfoRow('신청절차', 'ㅁㅁㅁ'),
                    ]),
                    SizedBox(height: 16),
                    
                    // 기타
                    _buildSection('기타', [
                      _buildInfoRow('주관기관', '교통기획관'),
                    ]),
                    
                    SizedBox(height: 100), // 하단 버튼 공간
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Color(0xFF111317),
        padding: EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _isSaved = !_isSaved; // 토글 방식으로 변경
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _isSaved ? Color(0xFF1447E6) : Color(0xFFF6F8FA), // blue/600 색상 적용
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              _isSaved ? '저장됨 ✓' : '저장',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: _isSaved ? Color(0xFFE1E5EC) : Color(0xFF1A1D23), // gray/100 색상 적용
                letterSpacing: -1.0,
                height: 24/20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFFF6F8FA),
            letterSpacing: -0.8,
            height: 18/16,
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 1,
          color: Color(0xFF353A44),
        ),
        SizedBox(height: 24),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF949CAD),
                letterSpacing: -0.7,
                height: 16/14,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFFE1E5EC),
                letterSpacing: -0.7,
                height: 16/14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getSupportContent() {
    return '''ㅇ 사업 근거
- 「청년기본법」 제4조(국가와 지방자치단체의 책무) 1항
- 「서울특별시 청년 기본 조례」 제15조(청년의 생활안정) 3항

ㅇ 추진 경과
- 기후동행카드 기자설명회 : '23.9.11
- 기후동행카드 시범사업 서비스 개시 : '24.1.27
- 기후동행카드 청년할인 혜택 적용 : '24.2.26
- 본사업 개시(청년할인 적용 및 사후환급 추진) : '24.7.1

ㅇ 사업 기간 : '24.7.1. 이후~ 계속

ㅇ 사업 대상 : 만 19~39세에 해당하는 청년
- '24년 기준 '85.1.1부터 '05.12.31에 해당하는 모든 청년 대상
- 단, 티머니 홈페이지 가입을 통해 본인 연령 인증 필수

ㅇ 사업 내용
- 청년할인 연령 대상에게 기후동행카드 정기권 7천원 할인 혜택

ㅇ '25년 사업비 : 10,500 백만원 (지방비 100%)''';
  }

  String _getRegionDetails() {
    return '서울특별시 종로구, 서울특별시 중구, 서울특별시 용산구, 서울특별시 성동구, 서울특별시 광진구, 서울특별시 동대문구, 서울특별시 중랑구, 서울특별시 성북구, 서울특별시 강북구, 서울특별시 도봉구, 서울특별시 노원구, 서울특별시 은평구, 서울특별시 서대문구, 서울특별시 마포구, 서울특별시 양천구, 서울특별시 강서구, 서울특별시 구로구, 서울특별시 금천구, 서울특별시 영등포구, 서울특별시 동작구, 서울특별시 관악구, 서울특별시 서초구, 서울특별시 강남구, 서울특별시 송파구, 서울특별시 강동구';
  }
}
