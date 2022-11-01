//
//  ProvinceCell.swift
//  TestSimple
//
//  Created by lidongyang on 2022/4/14.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class ProvinceCell: UITableViewCell {
    private let provinceLabel = UILabel()
    private let cityLabel = UILabel()
    private let addButton = UIButton()
    private let deleteButton = UIButton()
    var addAction: (() -> Void)?
    var deleteAction: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupSubView()
        setupLayout()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubView() {
        contentView.addSubview(provinceLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(deleteButton)
        deleteButton.setTitle("删除", for: .normal)
        deleteButton.backgroundColor = .lightGray
        deleteButton.layer.cornerRadius = 8
        deleteButton.layer.masksToBounds = true
        
        addButton.setTitle("添加", for: .normal)
        addButton.backgroundColor = .lightGray
        addButton.layer.cornerRadius = 8
        addButton.layer.masksToBounds = true
    }

    func setData(province: String, city: City) {
        self.provinceLabel.text = ""
        self.cityLabel.text = city.name
    }

    func setupLayout() {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.edges.equalToSuperview()
        }
        provinceLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.bottom.equalToSuperview()
        }
        cityLabel.snp.makeConstraints { make in
            make.left.equalTo(provinceLabel.snp.right).offset(30)
            make.top.bottom.equalToSuperview()
        }
        deleteButton.snp.makeConstraints { make in
            make.right.equalTo(addButton.snp_leftMargin).offset(-20)
            make.height.equalTo(20)
            make.width.equalTo(50)
            make.centerY.equalToSuperview()
        }
        addButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(20)
            make.width.equalTo(50)
            make.centerY.equalToSuperview()
        }
    }

    private func setupActions() {
        addButton.addTarget(self, action: #selector(addASameCity), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteCurrentCity), for: .touchUpInside)
    }

    @objc func updateCellBackgroundColor() {
        if contentView.backgroundColor == .white {
            contentView.backgroundColor = .green
        } else {
            contentView.backgroundColor = .white
        }
    }

    @objc func addASameCity() {
        addAction?()
    }

    @objc func deleteCurrentCity() {
        deleteAction?()
    }
}
