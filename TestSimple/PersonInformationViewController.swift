//
//  PersonInformationViewController.swift
//  TestSimple
//
//  Created by lidongyang on 2022/7/26.
//

import Foundation
import UIKit

class PersonInformationViewController: UIViewController {

    private let personInformationView = PersonInformationView()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.addSubview(personInformationView)
        personInformationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private class PersonInformationView: UIView {
    private let nameLabel = UILabel()
    private let passwordLabel = UILabel()
    private let nameTextField: UITextField
    private let passWordField: UITextField

    override init(frame: CGRect) {
        nameLabel.text = "账号："
        passwordLabel.text = "密码："
        nameTextField = PersonInformationView.textFieldSytle(placeholder: "请输入姓名")
        passWordField = PersonInformationView.textFieldSytle(placeholder: "请输入密码")

        super.init(frame: frame)
        setupSubView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubView() {
        addSubview(nameLabel)
        addSubview(passwordLabel)
        addSubview(nameTextField)
        addSubview(passWordField)

//        underline(color: .black)
        // 创建一条线，长度与文本框等长，宽度为2个像素
        let underLineName = UIView()
        // 定义下划线的颜色
        underLineName.backgroundColor = .lightGray
        // 把自定义的组建加入文本框中
        addSubview(underLineName)

        // 创建一条线，长度与文本框等长，宽度为2个像素
        let underLinePassword = UIView()
        // 定义下划线的颜色
        underLinePassword.backgroundColor = .lightGray
        // 把自定义的组建加入文本框中
        addSubview(underLinePassword)

        underLineName.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.width.equalTo(200)
            make.left.equalTo(nameTextField)
            make.bottom.equalTo(nameTextField.snp.bottom)
        }

        underLinePassword.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.width.equalTo(200)
            make.left.equalTo(passWordField)
            make.bottom.equalTo(passWordField.snp.bottom)
        }

        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(100)
            make.top.equalTo(150)
            make.height.equalTo(40)
        }
        passwordLabel.snp.makeConstraints { make in
            make.left.equalTo(100)
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.height.equalTo(40)
        }
        nameTextField.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        passWordField.snp.makeConstraints { make in
            make.centerY.equalTo(passwordLabel)
            make.left.equalTo(passwordLabel.snp.right).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
    }

    private static func textFieldSytle(placeholder: String) -> UITextField {
        let textField = UITextField()
//        nameTextField.backgroundColor = .lightGray
        textField.placeholder = placeholder

        // 輸入框的樣式 這邊選擇圓角樣式
        textField.borderStyle = .none

        // 輸入框右邊顯示清除按鈕時機 這邊選擇當編輯時顯示
        textField.clearButtonMode = .whileEditing

        // 輸入框適用的鍵盤 這邊選擇 適用輸入 Email 的鍵盤(會有 @ 跟 . 可供輸入)
        textField.keyboardType = .emailAddress

        // 鍵盤上的 return 鍵樣式 這邊選擇 Done
        textField.returnKeyType = .done

        // 輸入文字的顏色
        textField.textColor = UIColor.black

        return textField
    }

    private func underline(color: UIColor)
    {
        // 创建一条线，长度与文本框等长，宽度为2个像素
        let underLine = UIView()
        // 定义下划线的颜色
        underLine.backgroundColor = color
        // 把自定义的组建加入文本框中
        addSubview(underLine)
        underLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.width.equalTo(nameTextField.bounds.width)
            make.left.equalTo(nameTextField)
            make.bottom.equalTo(nameTextField.snp.bottom)
        }
    }

}
