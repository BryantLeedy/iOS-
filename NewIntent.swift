//
//  NewIntent.swift
//  TestSimple
//
//  Created by lidongyang on 2022/10/30.
//

import Foundation
import AppIntents

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct NewIntent: AppIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "NewIntentIntent"

    static var title: LocalizedStringResource = "New Intent"
    static var description = IntentDescription("")

    @Parameter(title: "Name")
    var name: String?

    static var parameterSummary: some ParameterSummary {
        Summary("mother fucker") {
            \.$name
        }
    }

    enum CustomDialog {
        case nameParameterPrompt
        case nameParameterDisambiguationIntro(Int, String)
        case nameParameterConfirmation(String)

        var asDialog: IntentDialog {
            switch self {
                case .nameParameterPrompt:
                    return IntentDialog("?????")
                case .nameParameterDisambiguationIntro(let count, let name):
                    return IntentDialog("There are \(count) options matching ‘\(name)’.")
                case .nameParameterConfirmation(let name):
                    return IntentDialog("Just to confirm, you wanted ‘\(name)’?")
            }
        }
    }

    func perform() async throws -> some IntentResult {
        // TODO: Place your refactored intent handler code here.
//        return .result()
        return .result(dialog: CustomDialog.nameParameterPrompt.asDialog)
    }
}

