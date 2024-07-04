//
//  MainViewController.swift
//  kioskProject
//
//  Created by 김승희 on 7/2/24.
//

import UIKit
import SnapKit
import SwiftUI

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let segmentedBar = SegmentedBar()
        self.view.addSubview(segmentedBar)
        segmentedBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(500)
        }
        
        let cartTableView = CartTableView()
        self.view.addSubview(cartTableView)
        cartTableView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }
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
