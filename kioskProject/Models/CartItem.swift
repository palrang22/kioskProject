//
//  CartItem.swift
//  kioskProject
//
//  Created by 김승희 on 7/4/24.
//

import Foundation

struct CartItem {
    let name: String        // 메뉴 이름
    let price: String       // 메뉴 가격
    var quantity: Int       // 메뉴 갯수(갯수는 항상 바뀌기 때문에 변수로 설정)
}

var cartItems: [CartItem] = []
