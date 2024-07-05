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
    
    let cartTableView = CartTableView() // 테이블 뷰 생성
    let segmentedBar = SegmentedBar()   // 세그먼트바 생성
    let totalAmount = UILabel()         // 총 금액 레이블
    let totalCount = UILabel()          // 총 갯수 레이블
    let logoImage = UIImageView()       // 로고
    let removeAllButton = UIButton()    // 전체삭제 버튼
    let calculateButton = UIButton()    // 결제 버튼

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // 이미지 구역
        self.view.addSubview(logoImage)
        logoImage.image = UIImage(named: "H4nsotlogo")
        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().offset(-100)
            make.height.equalTo(30)
        }
        
        // 세그먼트 바 구역
        self.view.addSubview(segmentedBar)
        segmentedBar.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(400)
        }
        
        // 금액, 갯수 레이블 구역
        labelSetting()
        
        // 테이블 뷰 구역
        self.view.addSubview(cartTableView)
        cartTableView.snp.makeConstraints{
            $0.top.equalTo(totalCount.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(200)
        }
        
        // 버튼 구역
        buttonSetting()
        
        // TableViewDelegate 사용
        cartTableView.delegate = self
        
        // CollectionViewDelegate 사용
        segmentedBar.firstView.delegate = self
        segmentedBar.secondView.delegate = self
        segmentedBar.thirdView.delegate = self
        segmentedBar.fourthView.delegate = self
    }
    
    // 레이블 세팅
    func labelSetting() {
        totalCount.text = "총 주문내역 0개"
        totalAmount.text = "총 금액 ₩0"
        totalCount.translatesAutoresizingMaskIntoConstraints = false
        totalAmount.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(totalCount)
        view.addSubview(totalAmount)
        
        totalCount.snp.makeConstraints { make in
            make.top.equalTo(segmentedBar.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(30)
            make.height.equalTo(20)
        }
        
        totalAmount.snp.makeConstraints { make in
            make.top.equalTo(segmentedBar.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(20)
        }
    }
    
    // 버튼 세팅
    func buttonSetting() {
        removeAllButton.setTitle("전체삭제", for: .normal)
        removeAllButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        removeAllButton.backgroundColor = UIColor(red: 218/255, green: 33/255, blue: 39/255, alpha: 1.0)
        removeAllButton.layer.cornerRadius = 10
        calculateButton.setTitle("계산하기", for: .normal)
        calculateButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        calculateButton.backgroundColor = UIColor(red: 243/255, green: 101/255, blue: 36/255, alpha: 1.0)
        calculateButton.layer.cornerRadius = 10
        removeAllButton.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        
        calculateButton.addTarget(self, action: #selector(calculateAlert), for: .touchUpInside)
        removeAllButton.addTarget(self, action: #selector(removeAllAlert), for: .touchUpInside)
        
        view.addSubview(removeAllButton)
        view.addSubview(calculateButton)
        
        removeAllButton.snp.makeConstraints { make in
            make.top.equalTo(cartTableView.snp.bottom).offset(20)
            make.leading.equalTo(cartTableView)
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
        
        calculateButton.snp.makeConstraints { make in
            make.top.equalTo(cartTableView.snp.bottom).offset(20)
            make.trailing.equalTo(cartTableView)
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
        
    }
    
    // MenuCollectionVeiw 에서 데이터 전달을 받은 후 데이터 처리
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
    
    // 레이블 정보 업데이트
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
    
    // 계산 버튼 클릭시 작동할 Alert 창
    @objc func calculateAlert() {
        let alert = UIAlertController(title: "결제하기", message: "정말로 결제하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.cartTableView.cartItems.removeAll()
            self.updateLable(self.cartTableView.cartItems)
            self.cartTableView.tableView.reloadData()
            self.calculateShowCompletionAlert()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            print("Cancel 버튼 누름")
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // 삭제버튼 클릭시 작동할 Alert 창
    @objc func removeAllAlert() {
        let alert = UIAlertController(title: "삭제하기", message: "정말로 모든 메뉴를 삭제하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.cartTableView.cartItems.removeAll()
            self.updateLable(self.cartTableView.cartItems)
            self.cartTableView.tableView.reloadData()
            self.deleteShowCompletionAlert()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            print("Cancel 버튼 누름")
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // 삭제 완료시 보여줄 Alert 창
    func deleteShowCompletionAlert() {
        let completionAlert = UIAlertController(title: "삭제 성공", message: "선택하신 메뉴들이 전부 삭제되었습니다.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        completionAlert.addAction(okAction)
        
        present(completionAlert, animated: true, completion: nil)
    }
    
    // 결제 완료시 보여줄 Alert 창
    func calculateShowCompletionAlert() {
        let completionAlert = UIAlertController(title: "결제 성공", message: "결제가 성공적으로 완료되었습니다.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        completionAlert.addAction(okAction)
        
        present(completionAlert, animated: true, completion: nil)
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
