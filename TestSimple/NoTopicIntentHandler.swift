//
//  NoTopicIntentHandler.swift
//  TestSimple
//
//  Created by lidongyang on 2022/10/29.
//

import Foundation
import Intents

//final class NoTopicIntentHandler: NSObject, NoTopicIntentIntentHandling {
//
//    func resolveCourse(for intent: NoTopicIntentIntent) async -> INStringResolutionResult {
//        print("=====Handle The resolveCourse")
//        return INStringResolutionResult.success(with: "数学")
//    }
//
//    public func handle(intent: NoTopicIntentIntent, completion: @escaping (NoTopicIntentIntentResponse) -> Void) {
//        print("=====Handle The Intent")
//        let response = NoTopicIntentIntentResponse(code: .havaNoIdea, userActivity: nil)
//        completion(response)
//    }
//
//    /// - Tag: confirm_intent
//    public func confirm(intent: NoTopicIntentIntent, completion: @escaping (NoTopicIntentIntentResponse) -> Void) {
//        print("=====Confirm The Intent")
//    }
//}
