//
// Created by Hemant Gokhale on 8/20/22.
//

import Foundation

let array1 = Array(0...19)

var isEven = false
var isDivisibleByFive = false

private func iterateOnce() {
    for _ in 0...999 {
        array1.forEach { number in
            isEven = number % 2 == 0
            isDivisibleByFive = number % 5 == 0
        }
    }
}

private func iterateTwice() {
    for _ in 0...999 {
        array1.forEach { number in
            isEven = number % 2 == 0
        }
        array1.forEach { number in
            isDivisibleByFive = number % 5 == 0
        }
    }
}

private func printTimeElapsed(message: String, operation: () -> Void) {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = (CFAbsoluteTimeGetCurrent() - startTime) * 1000
    print("\(message) - \(timeElapsed) milliseconds")
}

func runTimingTest() {
    printTimeElapsed(message: "iterateOnce ") { iterateOnce() }
    printTimeElapsed(message: "iterateTwice") { iterateTwice() }
}