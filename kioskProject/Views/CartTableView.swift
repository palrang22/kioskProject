//
//  CartTableView.swift
//  kioskProject
//
//  Created by 김승희 on 7/2/24.
//

// 선호님

import UIKit
import SnapKit

class CartTableView: UIView {
    var tableView = UITableView(frame: .zero, style: .plain)
    var cartItems: [CartItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init() {
        super.init(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "CartItemCell")
        setupTableView() // 테이블뷰 설정 함수 호출
        loadDefaultItems() // 기본 데이터 호출
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 테이블뷰 레이아웃
    private func setupTableView() {
        tableView.layer.borderColor = UIColor.darkGray.cgColor
        tableView.layer.borderWidth = 2.0
        tableView.backgroundColor = UIColor.lightGray
        addSubview(tableView)
        
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    // 데이터 받아오기 전 임의 함수 호출
    private func loadDefaultItems() {
        let defaultItems = [
            CartItem(name: "기본 메뉴 1", price: "5000", quantity: 1),
            CartItem(name: "기본 메뉴 2", price: "7000", quantity: 1)
        ]
        cartItems.append(contentsOf: defaultItems)
        tableView.reloadData()
    }
}


// 프로토콜 extension
extension CartTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count // 카트 항목 수 반환
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartTableViewCell
        let item = cartItems[indexPath.row]
        cell.configure(with: item) // 셀 구성 함수 호출
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cartItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic) // 삭제 애니메이션 설정
        }
    }
}
