//: [Previous](@previous)

import Foundation

var sharedResource = 10
var lock = NSLock()

//DispatchQueue.concurrentPerform(iterations: <#T##Int#>, execute: <#T##(Int) -> Void#>) {
func doWorkOnMultipleThreads() -> Bool {
    //var x = 5
    lock.lock()   //based on sharedResources and before getting out of their function
    sharedResource *= 10
    //lock.unlock()
    
    if sharedResource < 1000 {
        lock.unlock()
        return false
    } else if sharedResource > 1000 && sharedResource < 1500 {
        //lock.unlock()
        sharedResource *= 2
        lock.unlock()
        return true
    } else {
        //lock.lock()
        sharedResource -= 100
        //ock.unlock()
    }
    //lock.lock()
    sharedResource += 5
    lock.unlock()
    return true
}





//: [Next](@next)
