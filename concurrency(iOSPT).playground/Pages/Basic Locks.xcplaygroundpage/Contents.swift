import UIKit

//: # Example 1a (No Locks)

var x = 42
let xLock = NSLock()

DispatchQueue.concurrentPerform(iterations: 100) { (_) in
    xLock.lock()
    var localCopy = x
    localCopy += 1
    x = localCopy
    xLock.unlock()
}

print(x)


//: # Example 2a (Add Locks)
var sharedResource = 40
let lock = NSLock()

extension NSLock {
    func withLock(_ work: () -> Void) {
        lock()
        work()
        unlock()
    }
}

DispatchQueue.concurrentPerform(iterations: 5) { (threadNumber) in
    lock.withLock {
        print("Executing concurrent perform #\(threadNumber + 1)")
        var copyOfResource = sharedResource
        copyOfResource += 1
        sharedResource = copyOfResource
    }
}

print("Shared Resource: \(sharedResource)")


//: # Example 3
let sharedAccessQueue = DispatchQueue(label: "Shared Resource Queue")

DispatchQueue.concurrentPerform(iterations: 5) { (threadNumber) in
    sharedAccessQueue.async {
        print("Executing concurrent perform #\(threadNumber + 1)")
        
        var copyOfResource = sharedResource
        copyOfResource += 1
        sharedResource = copyOfResource
    }
}

print("Shared Resource: \(sharedResource)")

//: # Example 4
var listOfNames = Array<String>() // [String] = []
let nameLock = NSLock()

URLSession.shared.dataTask(with: URL(string: "http://swapi.co/people/1")!) { (data, response, error) in
    nameLock.lock()
    listOfNames.append("Luke")
    print(listOfNames)
    nameLock.unlock()
    }.resume()
print(listOfNames)



URLSession.shared.dataTask(with: URL(string: "http://swapi.co/people/3")!) { (data, response, error) in
    nameLock.lock()
    listOfNames.append("Han")
    print(listOfNames)
    nameLock.unlock()
    }.resume()
print(listOfNames)



URLSession.shared.dataTask(with: URL(string: "http://swapi.co/people/2")!) { (data, response, error) in
    nameLock.lock()
    listOfNames.append("Leia")
    print(listOfNames)
    nameLock.unlock()
    }.resume()
print("End: ", listOfNames)

//: [Next](@next)
