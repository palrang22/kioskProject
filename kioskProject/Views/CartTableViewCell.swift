//
//  CartTableViewCell.swift
//  kioskProject
//
//  Created by 김승희 on 7/2/24.
//

// 동준님

import UIKit
import SnapKit

// CartTableView 와 데이터를 주고밭기 위한 Delegate 생성
protocol CartTableViewCellDelegate: AnyObject {
    func didTapMinusButton(cell: CartTableViewCell)
    func didTapPlusButton(cell: CartTableViewCell)
}

class CartTableViewCell: UITableViewCell {
    let menuNameLabel = UILabel()
    let menuPriceLabel = UILabel()
    let menuQuantityLabel = UILabel()
    let minusButton = UIButton()
    let plusButton = UIButton()
    
    // 테이블 뷰에서 사용하기 위한 델리게이트 생성
    weak var delegate: CartTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupButtons()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // text 설정 함수 - CartTableView에서 사용
    func configure(with item: CartItem) {
        menuNameLabel.text = item.name
        if let price = Int(item.price) {
            menuPriceLabel.text = "₩\(price * item.quantity)"
        }
        menuQuantityLabel.text = "\(item.quantity)"
    }
    
    // StackView 생성 및 제약조건 설정
    private func configureUI() {
        
        // 각 요소(레이블, 버튼)의 크기를 설정하기 위한 제약조건 설정
        menuNameLabel.snp.makeConstraints { make in
            make.width.equalTo(140)
        }
        menuPriceLabel.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        menuQuantityLabel.snp.makeConstraints { make in
            make.width.equalTo(20)
        }
        minusButton.snp.makeConstraints { make in
            make.width.equalTo(20)
        }
        plusButton.snp.makeConstraints { make in
            make.width.equalTo(20)
        }
        
        // 각 라벨의 텍스트 정렬 설정
        menuQuantityLabel.textAlignment = .center
        
        // 만들어두신 객체 레이아웃 관리하기 편하도록 stackView에 담았습니다. 스택뷰 관련해서는 계산기 과제 Level 2를 확인해 보세요!
        let stackView = UIStackView(arrangedSubviews: [menuNameLabel, menuPriceLabel, minusButton, menuQuantityLabel, plusButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    // 버튼 세팅
    private func setupButtons() {
        minusButton.setTitle("-", for: .normal)
        plusButton.setTitle("+", for: .normal)
        minusButton.setTitleColor(.black, for: .normal)
        plusButton.setTitleColor(.black, for: .normal)
        
        // 버튼 로직 추가예정
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
    }
    
    @objc func didTapMinusButton(_ sender: UIButton) {
        // 빼기 버튼
        delegate?.didTapMinusButton(cell: self)
    }
    
    @objc func didTapPlusButton(_ sender: UIButton) {
        // 더하기 버튼
        delegate?.didTapPlusButton(cell: self)
    }
}
