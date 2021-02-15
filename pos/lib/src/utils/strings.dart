class StringConstant {
  static const String domain = 'Dohver';
  static const String version = '0.0.1';

  // 공통
  static const String cancle = '취소';
  static const String save = '저장';
  static const String add = '추가';

  // 버전 체크
  static const String errorVersion = '버전 에러';
  static const String desVersion =
      '버전이 다릅니다.\n업데이트를 해주세요.\n하지않을 경우, 이용이 불가능합니다.';

  // 로그인
  static const String bName = '상호명';
  static const String phone = '폰번호';
  static const String bItem = '업종';
  static const String bArea = '지역';
  static const String idLoginHint = "폰번호";
  static const String pwLoginHint = "상호명";
  static const String failID = '가입되어 있지 않은 폰번호입니다.';
  static const String failPW = '상호명(비밀번호)가 틀렸습니다.';
  static const String login = '로그인';
  static const String join = "가입하기";
  static const String backToLogin = "돌아가기";

  // 회원가입
  static const String messageIDPW = '폰번호가 아이디, 상호명이 비밀번호입니다.';
  static const String errorJoin = "제대로 입력했는지 확인해주세요.";
  static const String phoneField = "휴대폰번호, 숫자만! (예. 01012341234)";
  static const String nameField = "상호명 (예. 쁠랑)";
  static const String areaField = "지역 (예. 영천)";
  static const String itemField = "업종 (예. 카페)";
  static const String phoneValidateMessage = "폰번호를 확인해주세요. 숫자만 입력가능합니다.";
  static const String spaceValidateMessage = "빈칸은 불가능합니다.";
  static const String duplicatePhone = '이미 가입된 폰번호입니다.';

  // TAB
  static const String tabStats = '통계';
  static const String tabCal = '계산';
  static const String tabSetting = '설정';
  static const String tabReceipt = '영수증';

  // 계산 화면
  static const String noOrder = '주문이 없습니다.';
  static const String noCash = '0';
  static const String etc = '기타';
  static const String discount = '할인';
  static const String cash = '현금';
  static const String card = '카드';

  // 설정 화면
  static const String settingMenu = '메뉴 추가 및 변경';
  static const String settingCategory = '카테고리 추가 및 변경';
  static const String settingContact = '문의하기';
  static const String noCategory = '카테고리가 없습니다. 추가해주세요.';
  static const String noMenu = '메뉴가 없습니다. 추가해주세요.';
  static const String nameCategory = '카테고리명';
  static const String nameMenu = '메뉴명';
  static const String namePrice = '가격';
  static const String preorderCategory = '카테고리가 하나도 없습니다. 카테고리를 먼저 추가해 주세요.';

  // 영수증 화면
  static const String changeType = '결제변경';
  static const String noReceipt = '영수증이 하나도 없습니다.';

  // 통계 화면
  static const String noStats = '영수증이 하나도 없습니다.';
}
