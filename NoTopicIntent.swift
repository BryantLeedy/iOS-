//
//  NoTopicIntent.swift
//  TestSimple
//
//  Created by lidongyang on 2022/10/30.
//

import Foundation
import AppIntents

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct NoTopicIntent: AppIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "NoTopicIntentIntent"

    static var title: LocalizedStringResource = "请问要学习哪个科目"
    static var description = IntentDescription("你真的爱学习吗")

    @Parameter(title: "Course", default: "Math")
    var Course: String?

    static var parameterSummary: some ParameterSummary {
        Summary("你喜欢哪个科目啊 \(\.$Course)")
    }

    enum CustomDialog {
        case CourseParameterPrompt
        case CourseParameterDisambiguationIntro(Int, String)
        case CourseParameterDisambiguationSelection
        case CourseParameterConfirmation(String)
        case responseSuccess
        case responseFailure
        case responseHavaNoIdea

        var asDialog: IntentDialog {
            switch self {
                case .CourseParameterPrompt:
                    return IntentDialog("math")
                case .CourseParameterDisambiguationIntro(let count, let Course):
                    return IntentDialog("There are \(count) options matching ‘\(Course)’.")
                case .CourseParameterDisambiguationSelection:
                    return IntentDialog("Which course do you wannt?")
                case .CourseParameterConfirmation(let Course):
                    return IntentDialog("Just to confirm, you wanted ‘\(Course)’?")
                case .responseSuccess:
                    return IntentDialog("We success Bro")
                case .responseFailure:
                    return IntentDialog("fuck we fail!!")
                case .responseHavaNoIdea:
                    return IntentDialog("yuan shi nao tou")
            }
        }
    }

    func perform() async throws -> some IntentResult {
        // TODO: Place your refactored intent handler code here.
        return .result(value: String())
    }
}

