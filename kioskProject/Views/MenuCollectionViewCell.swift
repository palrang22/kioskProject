//
//  MenuCollectionViewCell.swift
//  kioskProject
//
//  Created by 김승희 on 7/2/24.
//

// 승희님

import UIKit
import SnapKit

class MenuCollectionViewCell: UICollectionViewCell {
    let menuImageView = UIImageView()
    let menuNameLabel = UILabel()
    let menuPriceLabel = UILabel()
    let stackView = UIStackView()
    let borderView = UIView() // 테두리 구현 위한 뷰
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupStackViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // image, namelabel, pricelabel 제약조건 설정
    func setupViews() {
        borderView.layer.borderColor = UIColor.lightGray.cgColor
        borderView.layer.borderWidth = 1.0
        borderView.layer.cornerRadius = 10
        borderView.layer.masksToBounds = true
        contentView.addSubview(borderView)
        
        borderView.snp.makeConstraints {
            $0.edges.equalTo(contentView).inset(5)
        }
        
        menuImageView.contentMode = .scaleAspectFill
        menuNameLabel.font = .boldSystemFont(ofSize: 15)
        menuPriceLabel.font = .systemFont(ofSize: 14)
        
        menuImageView.snp.makeConstraints {
            $0.width.height.equalTo(100)
        }
    }
    
    // 스택뷰 생성 및 제약조건 설정
    func setupStackViews() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        
        stackView.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(150)
        }
        
        stackView.addArrangedSubview(menuImageView)
        stackView.addArrangedSubview(menuNameLabel)
        stackView.addArrangedSubview(menuPriceLabel)
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.centerY.equalTo(contentView)
        }
    }
    // 셀 크기를 맞추기 위해 데이터가 빈값인 셀이 들어오면 안보이도록 처리
    
    // configure 함수 생성 - MenuCollectionView 에서 사용
    func configure(menuName: String, price: String, image: String){
        if menuName == "" && price == "" && image == "" {
            menuNameLabel.text = ""
            menuPriceLabel.text = ""
            menuImageView.backgroundColor = .white
            menuImageView.image = nil
        } else {
            menuNameLabel.text = menuName
            loadImage(from: image)
            menuPriceLabel.text = price + "원"
        }
    }
    
    // string url을 image로 변환
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to load image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to decode image data")
                return
            }
            
            DispatchQueue.main.async {
                self.menuImageView.image = image
            }
        }.resume()
    }
}
