//
//  ProvinceViewController.swift
//  TestSimple
//
//  Created by lidongyang on 2022/4/9.
//

import Foundation
import UIKit
import SnapKit

class ProvinceViewController: UIViewController {

    
//    private let backgroundView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 500, height: 700)))
    private let tableView = UITableView()
    private let model = ProvinceModel()
    private let cellIdentify = "provinceCell"
    private var currentIndex = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {
        self.navigationItem.title = "省份"
        
        tableView.register(ProvinceCell.self, forCellReuseIdentifier: cellIdentify)
        
        view.addSubview(tableView)
//        tableView.addSubview(backgroundView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.isUserInteractionEnabled = true
        self.tableView.allowsSelection = true
    }

    func setupLayouts() {
//        backgroundView.backgroundColor = .clear
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ProvinceViewController: UITableViewDataSource {

    
    public func numberOfSections(in tableView: UITableView) -> Int {
        model.provinces.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.provinces[section].city.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let province = model.provinces[indexPath.section]
        let city = province.city[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentify, for: indexPath) as! ProvinceCell
        cell.addAction = {
            self.model.addASameCity(index: indexPath)
            tableView.reloadData()
        }
        cell.deleteAction = {
            self.model.deleteTheCity(index: indexPath)
            tableView.reloadData()
        }
        cell.setData(province: province.name, city: city)
        if currentIndex == indexPath {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .white
        }
//        if indexPath.section == 0 {
//            cell.accessoryType = .detailButton
//        } else if indexPath.section == 1 {
//            cell.accessoryType = .checkmark
//        } else if indexPath.section == 2 {
//            cell.accessoryType = .detailDisclosureButton
//        } else if indexPath.section == 3 {
//            cell.accessoryType = .disclosureIndicator
//        }
        return cell
    }
}

extension ProvinceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("=======点击cell========")
        currentIndex = currentIndex == indexPath ? IndexPath() : indexPath
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "MF欢迎你"
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        bgView.backgroundColor = UIColor.lightGray
        let headerLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 60, y: 0, width: 120, height: 20))
        headerLabel.text = "\(model.provinces[section].name)欢迎你"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headerLabel.textAlignment = .center
        headerLabel.textColor = UIColor(hex: "#696969")
        bgView.addSubview(headerLabel)
        return bgView
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("点击了\(model.provinces[indexPath.section].city[indexPath.row].name)")
    }
}


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}


