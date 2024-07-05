//
//  CartTableView.swift
//  kioskProject
//
//  Created by 김승희 on 7/2/24.
//

// 선호님

import UIKit
import SnapKit

// MainViewController 에서 사용하기 위한 Delegate 생성
protocol CartTableViewDelegate: AnyObject {
    func didUpdateCartItems(_ items: [CartItem])
}


class CartTableView: UIView {
    var tableView = UITableView(frame: .zero, style: .plain)
    var cartItems: [CartItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // 데이터를 사용하기 위한 델리게이터 생성
    weak var delegate: CartTableViewDelegate?
    
    init() {
        super.init(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "CartItemCell")
        setupTableView() // 테이블뷰 설정 함수 호출
        //loadDefaultItems() // 기본 데이터 호출
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 테이블뷰 레이아웃
    private func setupTableView() {
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 1.0
        tableView.backgroundColor = UIColor.white
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
    
//    func updateItemQuantity(at indexPath: IndexPath, quantity: Int) {
//        cartItems[indexPath.row].quantity = quantity
//        tableView.reloadRows(at: [indexPath], with: .none)
//    }
    
    // 메뉴 갯수를 업데이트
    func updateItemQuantity(at indexPath: IndexPath, quantity: Int) {
        cartItems[indexPath.row].quantity = quantity
        tableView.reloadRows(at: [indexPath], with: .none)
        delegate?.didUpdateCartItems(cartItems)
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
        cell.delegate = self
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            cartItems.remove(at: indexPath.row)
    //            tableView.deleteRows(at: [indexPath], with: .automatic) // 삭제 애니메이션 설정
    //        }
    //    }
    //    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    //        return .none // 삭제 기능 비활성화
    //    }
    //
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        // 아무 작업도 하지 않음 - 삭제 기능 비활성화
    //    }
    //}
    
}

extension CartTableView: CartTableViewCellDelegate {
    // 마이너스 버튼 클릭 시 작동
    func didTapMinusButton(cell: CartTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let currentQuantity = cartItems[indexPath.row].quantity
            if currentQuantity > 1 {
                updateItemQuantity(at: indexPath, quantity: currentQuantity - 1)
            } else {
                showDeleteAlert(for: indexPath)
            }
        }
    }
    // 플러스 버튼 클릭 시 작동
    func didTapPlusButton(cell: CartTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let currentQuantity = cartItems[indexPath.row].quantity
            updateItemQuantity(at: indexPath, quantity: currentQuantity + 1)
        }
    }
    
    // 삭제 alert 및 alertaction 설정
    func showDeleteAlert(for indexPath: IndexPath) {
        let alert = UIAlertController(title: "삭제하기", message: "정말로 이 메뉴를 삭제하시겠습니까?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.cartItems.remove(at: indexPath.row)
            self.delegate?.didUpdateCartItems(self.cartItems)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        // 현재 단순 UIView 상태이므로 parentViewController를 찾아주는 메서드가 있어야 alert 표시 가능
        if let viewController = self.parentViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}

// responder를 따라 올라가다 다음 responder가 UIViewController일 경우 반환하여 parentViewController로 지정
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            parentResponder = responder.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
