import 'package:flutter/material.dart';
import '../widgets/search_header.dart';
import '../widgets/input_field.dart';
import '../widgets/select_field.dart';

class MyProfileEditScreen extends StatefulWidget {
  @override
  _MyProfileEditScreenState createState() => _MyProfileEditScreenState();
}

class _MyProfileEditScreenState extends State<MyProfileEditScreen> {
  String _birthDate = '';
  String? _selectedRegion;
  String? _selectedSchool;
  String? _selectedEducation;
  String? _selectedMajor;

  final List<String> _regions = [
    '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종',
    '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주'
  ];

  final List<String> _schools = [
    '국민대학교', '서울대학교', '연세대학교', '고려대학교', '성균관대학교',
    '한양대학교', '중앙대학교', '경희대학교', '한국외국어대학교', '서강대학교'
  ];

  final List<String> _educationLevels = [
    '고졸 미만', '고교 재학', '고졸 예정', '고교 졸업',
    '대학 재학', '대졸 예정', '대학 졸업', '석·박사', '기타', '제한없음'
  ];

  final List<String> _majors = [
    '인문계열', '사회계열', '상경계열', '이학계열',
    '공학계열', '예체능계열', '농산업계열', '기타', '제한없음'
  ];

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
            
            // 헤더
            SearchHeader(
              title: '프로필 수정',
              showBackButton: true,
              showSearchField: false,
              showFilterButton: false,
              onBackPressed: () => Navigator.pop(context),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    
                    // 생년월일 입력
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '생년월일(YYMMDD)',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF949CAD),
                            letterSpacing: -0.8,
                            height: 18/16,
                          ),
                        ),
                        SizedBox(height: 16),
                        InputField(
                          hintText: '생년월일을 입력해주세요.',
                          value: _birthDate,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          onChanged: (value) {
                            setState(() {
                              _birthDate = value;
                            });
                          },
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    // 지역 선택
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '지역',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF949CAD),
                            letterSpacing: -0.8,
                            height: 18/16,
                          ),
                        ),
                        SizedBox(height: 16),
                        SelectField(
                          hintText: '지역을 선택해주세요.',
                          value: _selectedRegion,
                          options: _regions,
                          onChanged: (value) {
                            setState(() {
                              _selectedRegion = value;
                            });
                          },
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    // 학교 선택
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '학교',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF949CAD),
                            letterSpacing: -0.8,
                            height: 18/16,
                          ),
                        ),
                        SizedBox(height: 16),
                        SelectField(
                          hintText: '학교를 선택해주세요.',
                          value: _selectedSchool,
                          options: _schools,
                          onChanged: (value) {
                            setState(() {
                              _selectedSchool = value;
                            });
                          },
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    // 학력 선택
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '학력',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF949CAD),
                            letterSpacing: -0.8,
                            height: 18/16,
                          ),
                        ),
                        SizedBox(height: 16),
                        SelectField(
                          hintText: '학력을 선택해주세요.',
                          value: _selectedEducation,
                          options: _educationLevels,
                          onChanged: (value) {
                            setState(() {
                              _selectedEducation = value;
                            });
                          },
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    // 전공 선택
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '전공',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF949CAD),
                            letterSpacing: -0.8,
                            height: 18/16,
                          ),
                        ),
                        SizedBox(height: 16),
                        SelectField(
                          hintText: '전공을 선택해주세요.',
                          value: _selectedMajor,
                          options: _majors,
                          onChanged: (value) {
                            setState(() {
                              _selectedMajor = value;
                            });
                          },
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 100), // 버튼 공간 확보
                  ],
                ),
              ),
            ),
            
            // 저장 버튼 (고정)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  // 저장 기능 구현
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF6F8FA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
                child: Text(
                  '저장',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1D23),
                    letterSpacing: -1.0,
                    height: 24/20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
