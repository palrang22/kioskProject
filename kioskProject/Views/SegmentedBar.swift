//
//  SegmentedBar.swift
//  kioskProject
//
//  Created by 김승희 on 7/2/24.
//

// 가혜님

import UIKit
import SnapKit

class SegmentedBar: UIView {
    let segmentedControl: UISegmentedControl = {
        let items = ["프리미엄", "사각도시락", "보울도시락", "추가메뉴"]
        let category = UISegmentedControl(items: items)
        category.selectedSegmentIndex = 0
        category.backgroundColor = .white
        return category
    }()  // ()는 클로저를 호출하는 구문
    
    // MenuCollectionView 불러오기
    let firstView = MenuCollectionView()
    let secondView = MenuCollectionView()
    let thirdView = MenuCollectionView()
    let fourthView = MenuCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white

        addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        segmentedControl.selectedSegmentTintColor = .yellow   // 선택된 세그먼트 배경색
        
        // 여기에 self를 weak로 캡처
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        [firstView, secondView, thirdView, fourthView]
                    .forEach { addSubview($0) }
        
        firstView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(400)
        }
        
        secondView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(400)
        }
        
        thirdView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(400)
        }
        
        fourthView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(400)
        }
        
        updateSegmentedControlAppearance() // 초기 세그먼트 컨드롤 외관 업데이트
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 세그먼트 값이 변경될 때 호출되는 메서드
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        firstView.isHidden = true
        secondView.isHidden = true
        thirdView.isHidden = true
        fourthView.isHidden = true

        // 선택된 세그먼트에 따라 해당 색상의 뷰를 보이도록 설정
        switch sender.selectedSegmentIndex {
        case 0:
            firstView.isHidden = false
        case 1:
            secondView.isHidden = false
        case 2:
            thirdView.isHidden = false
        case 3:
            fourthView.isHidden = false

        default:
            break
        }
        updateSegmentedControlAppearance()
    }
    
    // 세그먼트 컨트롤의 외관 업데이트 메서드
    func updateSegmentedControlAppearance() {
        let selectedAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black
            ]
            segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)

            // 나머지 세그먼트의 텍스트 색상 설정
            let normalAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.darkGray
            ]
            segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        }
}
