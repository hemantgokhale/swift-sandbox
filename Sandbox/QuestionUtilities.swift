//
//  QuestionUtilities.swift
//  Sandbox
//
//  Created by Hemant Gokhale on 11/11/21.
//
//

import Foundation
import CommonCrypto

@main
struct Main {
    static func main() async throws {
        for _ in 1...5 {
            let questionId = try await askQuestion()
            try await answerQuestion(questionId: questionId)
        }
    }

    static func answerQuestion(questionId: Int) async throws {
        try await updateQuestionState(questionId: questionId, newState: "ANSWERED")
    }

    static func updateQuestionState(questionId: Int, newState: String) async throws {
        let path = "custom/questions/\(questionId)/question-lifecycle-state"
        let body = "subState=\(newState)".data(using: String.Encoding.utf8)!
        try await post(path: path, body: body)
        print("Question state updated. Id: \(questionId), new state: \(newState)")
    }

    // Ask a question and return its id

    static func askQuestion() async throws -> Int {
        let timestamp = getTimestamp()
        let question = "What is the meaning of life? - Asked at \(timestamp)"
        let subject = "Philosophy"
        let user = "waitPageTutorAnswering@college.edu"
        let path = "custom/questions/"
        let body = "question=\(question)&subject=\(subject)&user=\(user)".data(using: String.Encoding.utf8)!
        let data = try await post(path: path, body: body)
        let questionId = Int(String(decoding: data!, as: UTF8.self))!
        print("Question asked. Id: \(questionId), question text: \(question)")
        return questionId
    }

    private static func getTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM y HH:mm a"
        let timestamp = dateFormatter.string(from: Date())
        return timestamp
    }

    static func post(path: String, body: Data) async throws -> Data? {
        let url = URL(string: "http://localhost/api/v1/")!.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        let (data, response) = try await URLSession.shared.data(for: request)
        return data
    }
}
