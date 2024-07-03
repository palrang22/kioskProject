//
//  MenuDecoder.swift
//  kioskProject
//
//  Created by 김승희 on 7/3/24.
//

import Foundation

// JSON 데이터를 로드
func loadJsonData(filename: String) -> Data? {
    guard let fileUrl = Bundle.main.url(forResource: filename, withExtension: "json") else {
        return nil
    }
    return try? Data(contentsOf: fileUrl)
}

// JSON 데이터를 디코딩
func decodeMenuItems(from data: Data) -> [MenuItem]? {
    let decoder = JSONDecoder()
    do {
        let menuData = try decoder.decode([String: [MenuItem]].self, from: data)
        return menuData["Menu"]
    } catch {
        print("JSON 데이터를 디코딩하는 데 실패했습니다: \(error)")
        return nil
    }
}

// MenuItems 배열을 전역적으로 사용할 수 있도록 선언
// menuItems 변수를 언래핑하여 사용
let menuItems: [MenuItem]? = {
    if let data = loadJsonData(filename: "Menu") {
        return decodeMenuItems(from: data)
    }
    return nil
}()
