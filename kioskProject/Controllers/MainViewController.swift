//
//  MainViewController.swift
//  kioskProject
//
//  Created by 김승희 on 7/2/24.
//

import UIKit
import SnapKit
import SwiftUI

class MainViewController: UIViewController, CustomCollectionViewDelegate, CartTableViewDelegate {
    
    let cartTableView = CartTableView()
    let segmentedBar = SegmentedBar()
    let totalAmount = UILabel()
    let totalCount = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(segmentedBar)
        segmentedBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(500)
        }
        
        self.view.addSubview(cartTableView)
        cartTableView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }
        cartTableView.delegate = self
        labelSetting()
        
        segmentedBar.firstView.delegate = self
        segmentedBar.secondView.delegate = self
        segmentedBar.thirdView.delegate = self
        segmentedBar.fourthView.delegate = self
    }
    
    func labelSetting() {
        totalCount.text = "총 주문내역 0개"
        totalAmount.text = "총 금액 ₩0"
        totalCount.translatesAutoresizingMaskIntoConstraints = false
        totalAmount.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(totalCount)
        view.addSubview(totalAmount)
        
        totalCount.snp.makeConstraints { make in
            make.top.equalTo(segmentedBar.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(20)
        }
        
        totalAmount.snp.makeConstraints { make in
            make.top.equalTo(segmentedBar.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(20)
        }
        
    }
    
    func didSelectMenuItem(_ item: MenuItem) {
        var isExist = false
        for (idx, cartItem) in cartTableView.cartItems.enumerated() {
            if cartItem.name == item.name {
                cartTableView.cartItems[idx].quantity += 1
                isExist = true
                break
            }
        }
        if !isExist {
            let cartItem = CartItem(name: item.name, price: item.price, quantity: 1)
            cartTableView.cartItems.append(cartItem)
        }
        updateLable(cartTableView.cartItems)
        cartTableView.tableView.reloadData()
    }
    
    func updateLable(_ items: [CartItem]) {
        var count = 0
        var amount = 0
        for i in items {
            if let price = Int(i.price) {
                amount += price * i.quantity
            }
            count += i.quantity
        }
        totalCount.text = "총 주문내역 \(count)개"
        totalAmount.text = "총 금액 ₩\(amount)"
    }
    // CartTableViewDelegate 메서드 구현
    func didUpdateCartItems(_ items: [CartItem]) {
        updateLable(items)
    }

}

struct PreView: PreviewProvider {
    static var previews: some View {
        MainViewController().toPreview()
    }
}
#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
#endif
