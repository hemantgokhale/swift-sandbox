//
// Created by Hemant Gokhale on 8/20/22.
//

import Foundation

@main
struct Main {
    static func main() async throws {
        try await askAndAnswer()
    }

    static func askAndAnswer() async throws {
        for _ in 1...5 {
            let questionId = try await QuestionUtilities.askQuestion()
            try await QuestionUtilities.answerQuestion(questionId: questionId)
        }
    }
}
