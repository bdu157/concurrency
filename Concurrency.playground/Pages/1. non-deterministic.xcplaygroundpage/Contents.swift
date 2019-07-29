import UIKit

var x = 42
DispatchQueue.concurrentPerform(iterations: 10) { ( _ ) in
    var localX = x
    localX += 1
    x = localX
}

print(x)


//non-deterministic
//we do no know the order in which things will happen
//deterministic -> something that can absolutely reasoned about

x = 42
let lock = NSLock()  //protocol NSLocking

DispatchQueue.concurrentPerform(iterations: 10) { ( iteration ) in
    //it is like restroom inside we lock while doing business and we unlock when we get out now there is nothing going on inside of restroom
    lock.lock()   //what happens when this gets executed
    print("iteration:\(iteration)")  //iteration is not in order but we do not care in this case since result of x is deterministic so it is a case by a case
    var localX = x
    localX += 1
    x = localX
    lock.unlock()
}

print(x) //this will be locked showing 52
//to make the iteration and result consistent we use serial queue

print("===========================")

let q = DispatchQueue(label: "xIncrementer")  //this is always in order another mutex - mutually exclusive
for i in 0..<10 {
    q.async {  //this would happen conurrently
        print("iteration: \(i)")
        var localX = x
        localX += 1
        x = localX
    }
}

q.sync { }
print(x)
