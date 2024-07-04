//
//  MenuItem.swift
//  kioskProject
//
//  Created by 김승희 on 7/2/24.
//

import Foundation

struct MenuItem: Codable {
    var name: String        // 메뉴 이름
    var price: String       // 메뉴 가격
    var image: String       // 메뉴 이미지
    var category: String    // 메뉴 카테고리
}

let menuItems: [MenuItem]? = {
    if let data = loadJsonData(filename: "Menu") {
        return decodeMenuItems(from: data)
    }
    return nil
}()
