//: [Previous](@previous)


//: # Example 5
import Foundation

var sharedResource = 0
let lock = NSLock()
let group = DispatchGroup()

let numberOfIterations = 20_000

var startTime = Date()

for _ in 0..<numberOfIterations {
    group.enter()
    DispatchQueue.global().async {
        lock.lock()
        sharedResource += 1
        lock.unlock()
        group.leave()
    }
}

group.wait()
var endTime = Date()

var elapsedTime = endTime.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate

print("Time elapsed to add \(numberOfIterations): \(elapsedTime) seconds")

//: # Example 6
let q = DispatchQueue(label: "Shared Access Queue")
sharedResource = 0

startTime = Date()

for _ in 0..<numberOfIterations {
    group.enter()
    q.async {
        sharedResource += 1
        group.leave()
    }
}

group.wait()

endTime = Date()

elapsedTime = endTime.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate

print("time elapsed to add \(numberOfIterations): \(elapsedTime) seconds")
//: [Next](@next)

