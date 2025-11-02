import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/search_header.dart';
import '../widgets/policy_card.dart';
import '../models/policy.dart';
import '../models/policy_filter.dart';
import 'policy_detail_screen.dart';
import 'explore_filter_screen.dart';
import 'explore_loading_screen.dart';

class ExploreResultsScreen extends StatefulWidget {
  final String searchQuery;
  final PolicyFilter? filter;

  const ExploreResultsScreen({
    Key? key,
    required this.searchQuery,
    this.filter,
  }) : super(key: key);

  @override
  _ExploreResultsScreenState createState() => _ExploreResultsScreenState();
}

class _ExploreResultsScreenState extends State<ExploreResultsScreen> {
  String _currentSearchText = '';
  List<Map<String, dynamic>> allPolicies = [
    {
      'title': '청년일자리 도약장려금',
      'description': '기업의 청년고용 확대를 지원하고, 취업애로 청년의 취업을 촉진함으로써, 청년고용 기업의 청년고용 확대를 지원하고, 취업애로 청년의 취업을 촉진함으로써, 청년고용 활성화를 목적으로 하는 정책',
      'category': '복지문화',
      'region': '서울',
      'deadline': '상시',
      'policyId': '20250522005400210865',
    },
    {
      'title': '기후동행카드(청년할인 서비스)',
      'description': '청년의 사회진출 지원 및 생활안정을 목적으로 청년할인 대상(만 19~39세)에게 기후동행카드 정기권의 할인 제공',
      'category': '참여권리',
      'region': '전국',
      'deadline': '상시',
      'policyId': '20250522005400210866',
    },
    {
      'title': '울산 동구 청년문화 구축 지원사업',
      'description': '서울청년센터 안정적 운영지원, 청년수당 등 주요 시책사업 추진 및 청년 사회안전망 구축 등 서울시 청년정책 집행·전달의 종합 컨트롤타워 기능 수행',
      'category': '복지문화',
      'region': '울산',
      'deadline': '신청마감 D-100',
      'policyId': '20250522005400210867',
    },
  ];

  // 필터에 따라 정책 목록을 필터링하는 메서드
  List<Map<String, dynamic>> get filteredPolicies {
    if (widget.filter == null) {
      return allPolicies;
    }
    
    return allPolicies.where((policy) {
      // 카테고리 필터링
      if (widget.filter!.mainCategory != null && 
          policy['category'] != widget.filter!.mainCategory) {
        return false;
      }
      
      // 지역 필터링
      if (widget.filter!.region != null && 
          policy['region'] != widget.filter!.region) {
        return false;
      }
      
      // 검색어 필터링 (제목이나 설명에 포함되는지 확인)
      if (_currentSearchText.isNotEmpty && _currentSearchText != '필터 검색') {
        final query = _currentSearchText.toLowerCase();
        final title = policy['title'].toString().toLowerCase();
        final description = policy['description'].toString().toLowerCase();
        if (!title.contains(query) && !description.contains(query)) {
          return false;
        }
      }
      
      return true;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _currentSearchText = widget.searchQuery;
    // 백엔드 연동 시 여기서 API 호출
    // _loadPolicies();
  }

  // 향후 백엔드 API 연동 메서드
  Future<void> _loadPolicies() async {
    // TODO: 백엔드 API 호출
    // final policies = await PolicyService.searchPolicies(
    //   query: widget.searchQuery,
    //   filter: widget.filter,
    // );
    // setState(() {
    //   allPolicies = policies;
    // });
  }

  @override
  Widget build(BuildContext context) {
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
            
            // 검색 헤더
            SearchHeader(
              showBackButton: true,
              showSearchField: true,
              showFilterButton: true,
              searchText: _currentSearchText,
              onBackPressed: () => Navigator.pop(context),
              onSearchChanged: (text) {
                setState(() {
                  _currentSearchText = text;
                });
              },
              onSearchSubmitted: (text) {
                if (text.trim().isNotEmpty) {
                  // 새로운 검색 실행 - 로딩 화면으로 이동
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExploreLoadingScreen(searchQuery: text.trim()),
                    ),
                  );
                }
              },
              onClearPressed: () {
                setState(() {
                  _currentSearchText = '';
                });
              },
              onFilterPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExploreFilterScreen(),
                  ),
                );
              },
            ),
            
            Expanded(
              child: filteredPolicies.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Color(0xFF6A7180),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '검색 결과가 없습니다',
                            style: TextStyle(
                              fontFamily: 'Noto Sans',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6A7180),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '다른 조건으로 검색해보세요',
                            style: TextStyle(
                              fontFamily: 'Noto Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF949CAD),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      itemCount: filteredPolicies.length,
                      itemBuilder: (context, index) {
                        final policy = filteredPolicies[index];
                        return PolicyCard(
                          title: policy['title'],
                          description: policy['description'],
                          category: policy['category'],
                          region: policy['region'],
                          deadline: policy['deadline'],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PolicyDetailScreen(
                                  policyId: policy['policyId'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: YunoBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              // 현재 탐색 화면
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/saved');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/my');
              break;
          }
        },
      ),
    );
  }
}
