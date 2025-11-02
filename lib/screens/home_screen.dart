import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../models/policy.dart';

class HomeScreen extends StatefulWidget {
  final List<String> selectedInterests;
  final Map<String, String> profileData;

  HomeScreen({
    required this.selectedInterests,
    required this.profileData,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _refreshCount = 3; // 새로고침 가능 횟수

  void _refreshAiRecommendations() {
    if (_refreshCount > 0) {
      setState(() {
        _refreshCount--;
      });
      // TODO: 백엔드에서 새로운 AI 추천 정책을 가져오는 로직
    }
  }

  String _getPolicyIdFromTitle(String title) {
    // 정책 제목을 기반으로 ID 생성 (실제로는 백엔드에서 제공받을 정책 ID 사용)
    Map<String, String> titleToId = {
      '청년일자리 도약장려금': 'policy_youth_job_incentive',
      '청년희망키움통장': 'policy_youth_hope_savings',
      '기후동행카드(청년할인 서비스)': 'policy_climate_card_youth',
    };
    return titleToId[title] ?? 'policy_default';
  }

  // 더미 데이터
  final List<Policy> aiRecommendedPolicies = [
    Policy(
      id: '1',
      plcyNm: '청년일자리 도약장려금',
      bscPlanPlcyWayNoNm: '복지문화',
      plcyExplnCn: '청년들의 취업을 지원하는 정책입니다.',
      rgtrupInstCdNm: '서울',
      aplyPrdSeCd: '상시',
      aplyPrdEndYmd: '',
      applicationUrl: '',
      requirements: [],
    ),
    Policy(
      id: '2',
      plcyNm: '청년희망키움통장',
      bscPlanPlcyWayNoNm: '복지문화',
      plcyExplnCn: '청년들의 자산형성을 지원하는 정책입니다.',
      rgtrupInstCdNm: '서울',
      aplyPrdSeCd: '상시',
      aplyPrdEndYmd: '',
      applicationUrl: '',
      requirements: [],
    ),
    Policy(
      id: '3',
      plcyNm: '기후동행카드(청년할인 서비스)',
      bscPlanPlcyWayNoNm: '복지문화',
      plcyExplnCn: '청년들의 교통비 부담을 줄여주는 정책입니다.',
      rgtrupInstCdNm: '서울',
      aplyPrdSeCd: '상시',
      aplyPrdEndYmd: '',
      applicationUrl: '',
      requirements: [],
    ),
  ];

  final List<Map<String, dynamic>> popularPolicies = [
    {
      'title': '청년일자리 도약장려금',
      'views': 4769,
      'saves': 134,
    },
    {
      'title': '청년희망키움통장',
      'views': 1035,
      'saves': 91,
    },
    {
      'title': '기후동행카드(청년할인 서비스)',
      'views': 359,
      'saves': 20,
    },
  ];

  // 저장된 정책 중 31일 이내 마감 정책들 (실제로는 백엔드에서 가져올 데이터)
  List<Map<String, dynamic>> get upcomingSchedules {
    // TODO: 백엔드에서 사용자가 저장한 정책 중 31일 이내 마감 정책을 가져오는 로직
    return [
      {
        'title': '청년내일채움공제',
        'deadline': 'D-4',
        'isUrgent': true,
        'policyId': 'policy_youth_tomorrow_savings',
      },
      {
        'title': '청년희망키움통장',
        'deadline': 'D-7',
        'isUrgent': true,
        'policyId': 'policy_youth_hope_savings',
      },
      {
        'title': '기후동행카드(청년할인 서비스)',
        'deadline': 'D-12',
        'isUrgent': false,
        'policyId': 'policy_climate_card_youth',
      },
      {
        'title': '울산 동구 청년문화 구축 지원사업',
        'deadline': 'D-23',
        'isUrgent': false,
        'policyId': 'policy_ulsan_youth_culture',
      },
      {
        'title': '청년창업지원사업',
        'deadline': 'D-31',
        'isUrgent': false,
        'policyId': 'policy_youth_startup',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111317),
      body: SafeArea(
        child: Column(
          children: [
            // Status bar area
            Container(
              height: 32,
              color: Colors.transparent,
            ),

            // 헤더 영역
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/yuno_logo_frame.png',
                    width: 110,
                    height: 32,
                  ),
                ],
              ),
            ),

            // 스크롤 가능한 콘텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),

                    // 오늘의 AI 추천 정책 섹션
                    _buildAiRecommendationSection(),

                    SizedBox(height: 16),

                    // 추천 버튼 영역
                    _buildRecommendationButtons(),

                    SizedBox(height: 16),

                    // 인기 정책 TOP3
                    _buildPopularPoliciesSection(),

                    SizedBox(height: 16),

                    // 주요 알림 배너
                    _buildNotificationBanner(),

                    SizedBox(height: 16),

                    // 다가오는 일정
                    _buildUpcomingScheduleSection(),

                    SizedBox(height: 100), // 하단 여백
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: YunoBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              // 현재 홈 화면
              break;
            case 1:
              Navigator.pushNamed(context, '/explore');
              break;
            case 2:
              Navigator.pushNamed(context, '/saved');
              break;
            case 3:
              Navigator.pushNamed(context, '/my');
              break;
          }
        },
      ),
    );
  }

  Widget _buildAiRecommendationSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF252931), // 상단 왼쪽 - 약간 밝은 회색
            Color(0xFF1A202C), // 중간 - 어두운 회색
            Color(0xFF2D1B69), // 하단 오른쪽 - 보라색 톤
          ],
          stops: [0.0, 0.6, 1.0],
        ),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          // 헤더
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '오늘의 AI 추천 정책',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFF6F8FA).withOpacity(0.5),
                      letterSpacing: -0.8,
                      height: 24/16,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _refreshAiRecommendations,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/restart.png',
                          width: 12,
                          height: 12,
                        ),
                        SizedBox(width: 2),
                        Text(
                          '새로고침  $_refreshCount/3',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF949CAD),
                            letterSpacing: -0.6,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // AI 추천 정책 리스트
          ...aiRecommendedPolicies.map((policy) => _buildAiPolicyCard(policy)),
        ],
      ),
    );
  }

  Widget _buildAiPolicyCard(Policy policy) {
    return GestureDetector(
      onTap: () {
        // 해당 정책의 상세 페이지로 이동
        Navigator.pushNamed(
          context, 
          '/policy_detail',
          arguments: policy.id,
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  policy.title,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF6F8FA),
                    letterSpacing: -0.9,
                    height: 24/18,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  policy.aplyPrdSeCd,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6A7180),
                    letterSpacing: -0.6,
                    height: 14/12,
                  ),
                ),
              ],
            ),
          ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF162455),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    policy.category,
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
                SizedBox(width: 2),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF002D21),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    policy.region,
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
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationButtons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/explore');
            },
            child: Container(
              height: 69,
              decoration: BoxDecoration(
                color: Color(0xFF252931),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 1,
                    bottom: -1.5,
                    child: Image.asset(
                      'assets/icons/search_home.png',
                      width: 64,
                      height: 64,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '내게 맞는',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF949CAD),
                            letterSpacing: -0.6,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '정책 찾기',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFF6F8FA),
                            letterSpacing: -0.8,
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/my_interests_edit');
            },
            child: Container(
              height: 69,
              decoration: BoxDecoration(
                color: Color(0xFF252931),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 1,
                    bottom: -1.5,
                    child: Image.asset(
                      'assets/icons/star_home.png',
                      width: 64,
                      height: 64,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '내 정보 입력하고',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF949CAD),
                            letterSpacing: -0.6,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '맞춤 정책 추천 받기',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFF6F8FA),
                            letterSpacing: -0.8,
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationBanner() {
    return GestureDetector(
      onTap: () {
        // 청년내일채움공제 정책 상세 페이지로 이동
        Navigator.pushNamed(
          context, 
          '/policy_detail',
          arguments: 'policy_youth_tomorrow_savings', // 정책 ID
        );
      },
      child: Container(
        height: 64,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xFF252931),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/clock.png',
              width: 40,
              height: 40,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '신청 마감 임박 안내',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFBDC4D0),
                      letterSpacing: -0.6,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '오늘 청년내일채움공제 신청 마감일이에요!',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF6F8FA),
                      letterSpacing: -0.8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularPoliciesSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF252931),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '인기 정책 TOP3',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF949CAD),
              letterSpacing: -0.8,
            ),
          ),
          SizedBox(height: 8),
          ...popularPolicies.map((policy) => _buildPopularPolicyCard(policy)),
        ],
      ),
    );
  }

  Widget _buildPopularPolicyCard(Map<String, dynamic> policy) {
    return GestureDetector(
      onTap: () {
        // 해당 정책의 상세 페이지로 이동
        String policyId = _getPolicyIdFromTitle(policy['title']);
        Navigator.pushNamed(
          context, 
          '/policy_detail',
          arguments: policyId,
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                policy['title'],
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFF6F8FA),
                  letterSpacing: -0.9,
                  height: 24/18,
                ),
              ),
            ),
            Row(
              children: [
                Image.asset(
                  'assets/icons/eye.png',
                  width: 16,
                  height: 16,
                ),
                SizedBox(width: 2),
                Text(
                  policy['views'].toString(),
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6A7180),
                    letterSpacing: -0.6,
                    height: 14/12,
                  ),
                ),
                SizedBox(width: 8),
                Image.asset(
                  'assets/icons/bookmark_home.png',
                  width: 16,
                  height: 16,
                ),
                SizedBox(width: 2),
                Text(
                  policy['saves'].toString(),
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6A7180),
                    letterSpacing: -0.6,
                    height: 14/12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingScheduleSection() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/saved');
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF252931),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '다가오는 일정',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF949CAD),
                letterSpacing: -0.8,
              ),
            ),
            SizedBox(height: 8),
            ...upcomingSchedules.take(5).map((schedule) => _buildUpcomingScheduleCard(schedule)),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingScheduleCard(Map<String, dynamic> schedule) {
    return GestureDetector(
      onTap: () {
        // 저장 탭으로 이동
        Navigator.pushNamed(context, '/saved');
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                schedule['title'],
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFF6F8FA),
                  letterSpacing: -0.9,
                  height: 24/18,
                ),
              ),
            ),
            Text(
              '신청 마감 ${schedule['deadline']}',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: schedule['isUrgent'] ? Color(0xFFFF6467) : Color(0xFF6A7180),
                letterSpacing: -0.6,
                height: 14/12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}