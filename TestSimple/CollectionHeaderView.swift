//
//  CollectionHeaderView.swift
//  TestSimple
//
//  Created by lidongyang on 2022/7/19.
//

import Foundation
import UIKit

final class CollectionHeaderView: UICollectionReusableView {

    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 20))

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor(hex: "#d3d3d3")
        addSubview(label)
        label.textColor = UIColor.black
        label.showsExpansionTextWhenTruncated = true
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
