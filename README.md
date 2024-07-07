# 한솥 4조 - 한솥 메뉴판 키오스크 프로젝트

## 프로젝트 개요

### 1. 팀 구성

- **팀:** 4조
- **팀원:** 김승희, 전가혜, 김동준, 이선호, 박승환

---

### 2. 프로젝트 목적

- **목표:** 한솥 메뉴 키오스크 만들기

---

### 3. 프로젝트 일정

- **기간:** 7월 2일 ~ 7월 5일 (4일간)

---

### 4. 프로젝트 기획

1. **주제 선정**
2. **Wireframe 생성**
    - Figma 협업 기능 사용
3. **체크리스트 생성**
    - 생성한 Wireframe에 따라 필수 및 추가 항목 체크리스트 작성
4. **역할 분배**
    - 승희님: Swift 파일 기본 구조 생성, json 파일 생성, 데이터 모델 생성, 메뉴판 셀 디자인 (`CollectionView Cell`) - 사진, 메뉴이름, 가격
    - 동준님: 장바구니 셀 디자인 (`TableView Cell`) - 메뉴(label), 가격(label), `UIStepper` (+ 가격라벨 변경로직)
    - 선호님: 장바구니 테이블뷰 제작 (`TableView`) - 필수 Delegate
    - 승환님: Swift 파일 기본 구조 생성, 메뉴판 콜렉션뷰 제작 (`CollectionView`), `didselectItemAt` 로직구현 (장바구니로 넘어감)
    - 가혜님: 상단바 제작 (`Segmented Control`) - Category에 따라 표시 목록 변경
5. **초기 파일 구조**
    
    ```
    kioskProject/
    ├── Models/
    │   ├── MenuItem.swift
    │   └── MenuDecoder.swift
    │		└── CartItem.swift
    ├── Views/
    │   ├── MenuCollectionView.swift
    │   └── MenuCollectionViewCell.swift
    │   └── CartTableView.swift
    │   └── CartTableViewCell.swift
    │   └── SegmentedBar.swift
    ├── Controllers/
    │   └── MainViewController.swift
    ├── Resources/
    │		└── Menu.json
    ├── AppDelegate.swift
    └── SceneDelegate.swift
    ```

---

### 5. 프로젝트 컨벤션

- **커밋 컨벤션 사용**
- **브랜치 전략:** git branch 전략 사용 (main - feat 여러개)
- PR rule 생성 → 2명 이상 approve시 merge 가능
- PR 템플릿 사용

---

### 6. 데이터베이스

- **데이터 소스:** GPT를 이용해 크롤링
- **형식:** JSON 형식 사용
- [참고 링크: Codable](https://bmwe3.tistory.com/1765)

---

### 7. 기술 스택

- **협업 툴:** Figma, Git
- **개발 언어:** Swift
- **데이터베이스:** JSON (GPT로 크롤링)
- **버전 관리:** Git (main - feat 브랜치 전략 사용)

## 와이어프레임

<img width="420" alt="image" src="https://github.com/palrang22/kioskProject/assets/92323612/2a7977a2-172c-4009-865e-93fb55cdbb70">

## 기능 체크리스트

### 필수 구현 기능

- [x]  메인 페이지
    - [x]  키오스크 화면을 보여주는 페이지 구성
    - [x]  키오스크 화면 자체가 하나의 ViewController
        - [x]  아래의 각 부분을 UI 컴포넌트로 잘 분리하기
    
- [x]  상단 메뉴 카테고리 바
    - [x]  메뉴 카테고리(ex. 추천메뉴, 햄버거, 디저트/치킨 등)를 정의하고 메뉴 구성
    - [x]  `UISegmentedControl` *,* `UIStackView` , `UICollectionView` 등을 활용하여 화면을 구성
    
- [x]  메뉴 화면
    - [x]  특정 메뉴 카테고리 클릭 시, 메뉴 카테고리에 해당하는 메뉴들을 표시
    - [x]  `UICollectionView` 등을 활용하여 화면을 구성
    
- [x]  주문 내역 화면
    - [x]  총 주문 메뉴 개수를 “총 주문내역 X개” 로 표시해주세요
    - [x]  주문한 메뉴들이 표시될 수 있도록 구성해주세요
        - [x]  각 메뉴를 표시하면서 각 메뉴 옆에 `+`, `-`버튼을 만들어서 해당 메뉴의 수량을 조정
    - [x]  `UITableView` 등을 활용하여 화면을 구성해보세요

- [x]  취소하기 / 결제하기 버튼 화면
    - [x]  주문 메뉴 전체를 취소하는 취소하기 버튼을 구현
    - [x]  주문 메뉴 전체를 결제하는 결제하기 버튼을 구현

### 추가 구현 기능

- [ ]  검색바 구현
- [x]  페이지 컨트롤
- [x]  결제하기 버튼 클릭시 Alert

### 구현 gif

|세그먼트바-메뉴콜렉션뷰|장바구니 테이블뷰|개수 조정 및 삭제|주문버튼 클릭시 처리|
|:--------------------------:|:--------------------------:|:--------------------------:|:--------------------------:|
|![Simulator Screen Recording - iPhone 15 Pro - 2024-07-07 at 19 02 29](https://github.com/palrang22/kioskProject/assets/92323612/4c932f79-6fc4-4ac5-9265-6113b46cd86f)|![Simulator Screen Recording - iPhone 15 Pro - 2024-07-07 at 19 02 51](https://github.com/palrang22/kioskProject/assets/92323612/f89f51dd-4f03-4ae4-9550-4bf691580a18)|![Simulator Screen Recording - iPhone 15 Pro - 2024-07-07 at 19 03 18](https://github.com/palrang22/kioskProject/assets/92323612/0e3d4148-e83f-4740-b9b3-eda66f1efe50)|![Simulator Screen Recording - iPhone 15 Pro - 2024-07-07 at 19 03 38](https://github.com/palrang22/kioskProject/assets/92323612/44e6bfe8-6e56-4b26-af10-77249a373ee2)|

