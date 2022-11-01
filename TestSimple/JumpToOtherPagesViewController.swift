//
//  JumpToOtherPagesViewController.swift
//  TestSimple
//
//  Created by lidongyang on 2022/7/25.
//

import Foundation
import UIKit
import Intents
import AppIntents
import IntentsUI

fileprivate extension CGFloat {
    static let buttonWidth = 80
    static let buttonHeight = 40
    static let buttonOffset = 40
}

final class JumpToOtherPagesViewController: UIViewController, INUIAddVoiceShortcutViewControllerDelegate, INUIAddVoiceShortcutButtonDelegate, INUIEditVoiceShortcutViewControllerDelegate {
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        if let error = error as NSError? {
            print("Error editing voice shortcut \(error)")
        }
        controller.dismiss(animated: true, completion: nil)
    }

    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }

    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }

    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }

    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        //
        if let error = error as NSError? {
            print("Error editing voice shortcut \(error)")
        }
        controller.dismiss(animated: true, completion: nil)
    }

    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }


    private let jumpButton1 = UIButton()
    private let jumpButton2 = UIButton()
    private let jumpButton3 = UIButton()
    private lazy var jumpButtons = [jumpButton1,jumpButton2,jumpButton3]

    private var intent = INIntent()
    var newIntent = INIntent()

    private let userActivityProperty = NSUserActivity(activityType: "com.yuanfudao.dylee")


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupSubViews()
        setupAction()
        setupNSUserActivity()

    }

    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 16.0, *) {
            setupIntents()
            setupAIntents()
            AppShortcuts.updateAppShortcutParameters()
        }
        setupVoice()
        setupShortcutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @available(iOS 16.0, *)
    private func setupIntents() {
        let noTopic = NewIntentIntent()
        noTopic.name = "Tom Dwon"
        print("===== Donate !!")
        noTopic.suggestedInvocationPhrase = "猎杀时刻"
        intent = noTopic
        let interaction = INInteraction(intent: noTopic, response: nil)
//        interaction.identifier = "NoTopicIntent"
        interaction.donate { error in
            if error != nil {
                if let error = error as NSError? {
                    print("Interaction donation failed: \(error)")
                }
            } else {
                print("Successfully donated interaction")
            }
        }
    }

    @available(iOS 16.0, *)
    private func setupAIntents() {
        let intent = TestIntentIntent()
        print("===== AAAA Donate !!")
        intent.suggestedInvocationPhrase = "作业时间"
        self.newIntent = intent
        let interaction = INInteraction(intent: newIntent, response: nil)

        interaction.donate { error in
            if error != nil {
                if let error = error as NSError? {
                    print("Interaction donation failed: \(error)")
                }
            } else {
                print("Successfully donated interaction")
            }
        }
    }

    private func setupNSUserActivity() {
        userActivityProperty.isEligibleForSearch = true
        userActivityProperty.isEligibleForPrediction = true
        userActivityProperty.title = "This is A Title"
        userActivityProperty.keywords = ["11","22","33"]
        self.userActivity = userActivityProperty
    }

    private func setupVoice() {
        print("setupVoice IN")
        let suggestions = [
         INShortcut(intent: intent)!,
         INShortcut(intent: newIntent)!
//         INShortcut(userActivity: userActivityProperty)
        ]
        INVoiceShortcutCenter.shared.setShortcutSuggestions(suggestions)
        print("Successfully setupVoice ")
    }

    private func setupShortcutUI() {
        let shortcut = INShortcut(intent: intent)

        let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut!)
        viewController.delegate = self
        present(viewController, animated: true)
    }

    private func setupSubViews() {
        view.addSubview(jumpButton1)
        view.addSubview(jumpButton2)
        view.addSubview(jumpButton3)
        jumpButtons.forEach { btn in
            btn.backgroundColor = .darkGray
        }
        jumpButton1.setTitle("相册", for: .normal)
        jumpButton2.setTitle("个人信息", for: .normal)
        jumpButton3.setTitle("弹窗", for: .normal)
    
        jumpButton1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
            make.width.equalTo(CGFloat.buttonWidth)
            make.height.equalTo(CGFloat.buttonHeight)
        }
        jumpButton2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(jumpButton1.snp_bottomMargin).offset(CGFloat.buttonOffset)
            make.width.equalTo(CGFloat.buttonWidth)
            make.height.equalTo(CGFloat.buttonHeight)
        }
        jumpButton3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(jumpButton2.snp_bottomMargin).offset(CGFloat.buttonOffset)
            make.width.equalTo(CGFloat.buttonWidth)
            make.height.equalTo(CGFloat.buttonHeight)
        }
    }

    private func setupAction() {
        jumpButton1.addTarget(self, action: #selector(jumpToVC1), for: .touchUpInside)
        jumpButton2.addTarget(self, action: #selector(jumpToVC2), for: .touchUpInside)
        jumpButton3.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }

    @objc private func jumpToVC1() {
        let vc = MessageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func jumpToVC2() {
        let vc = PersonInformationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func showAlert() {
        let alert = UIAlertController(title: "健康宝弹窗", message: "因为你河南村镇银行有钱，你TM待着别动", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "滚！！", style: .cancel)
        let action2 = UIAlertAction(title: "还不滚！！", style: .destructive)

        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true)
    }
}


struct AppShortcuts: AppShortcutsProvider {
    @available(iOS 16.0, *)
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: NewIntent(), phrases: [
            "Say hi with baba",
            "Tell mom I said hi with baba"
        ])
    }
}
