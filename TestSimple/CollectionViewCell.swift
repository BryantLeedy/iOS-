//
//  CollectionViewCell.swift
//  TestSimple
//
//  Created by lidongyang on 2022/7/18.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.width.height.equalTo(100)
        }
    }
}
