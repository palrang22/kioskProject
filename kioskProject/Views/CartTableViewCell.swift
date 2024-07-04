//
//  CartTableViewCell.swift
//  kioskProject
//
//  Created by 김승희 on 7/2/24.
//

// 동준님

import UIKit
import SnapKit

class CartTableViewCell: UITableViewCell {
    let menuNameLabel = UILabel()
    let menuPriceLabel = UILabel()
    let menuQuantityLabel = UILabel()
    let minusButton = UIButton()
    let plusButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // text 설정 함수 - CartTableView에서 사용
    func configure(with item: CartItem) {
        menuNameLabel.text = item.name
        menuPriceLabel.text = "₩\(item.price)"
        menuQuantityLabel.text = "\(item.quantity)개"
    }
    
    // StackView 생성 및 제약조건 설정
    private func configureUI() {
        
        // 만들어두신 객체 레이아웃 관리하기 편하도록 stackView에 담았습니다. 스택뷰 관련해서는 계산기 과제 Level 2를 확인해 보세요!
        let stackView = UIStackView(arrangedSubviews: [menuNameLabel, menuPriceLabel, menuQuantityLabel, minusButton, plusButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    private func setupButtons() {
        minusButton.setTitle("-", for: .normal)
        plusButton.setTitle("+", for: .normal)
        minusButton.setTitleColor(.black, for: .normal)
        plusButton.setTitleColor(.black, for: .normal)
        
        // 버튼 로직 추가예정
    }
}
