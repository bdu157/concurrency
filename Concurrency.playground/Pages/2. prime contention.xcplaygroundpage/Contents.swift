//: [Previous](@previous)

import Foundation

func isPrime(_ x: Int) -> Bool {
    if x < 2 {return false}
    if x == 2 {return true}
    for i in 2 ..< x {
        if x % i == 0 {
            return false
        }
    }
    return true
}

isPrime(37)
isPrime(42)

/*
func allPrimes(upTo n: Int) -> [Int] {
    var primes: [Int] = []
    
    for i in 2 ..< n {
        if isPrime(i) {
            primes.append(i)
        }
    }
    return primes
}
*/
//print(allPrimes(upTo:100000))

func contention_allPrimes(upTo n: Int) -> [Int] {
    
    var primes: [Int] = []
    let lock = NSLock()
    
    DispatchQueue.concurrentPerform(iterations: n) { number in
        if isPrime(number) {
            var primesCopy = primes
            lock.lock()
            primes.append(number)  // x += 1 race condition about 49 times we ran into a problem we have got a race condition
            lock.unlock() //this will make it slower since
            primes = primesCopy
        }
    }
    return primes
}

let batchedResult = contention_allPrimes(upTo: 100_000)
print(batchedResult.count) //expect: 9592

//: [Next](@next)

/*
func batching_allPrimes(upTo n: Int) -> [Int] {
    var primes: [Int] = []
    var lock = NSLock()
    let numberOfBatches = 5
    DispatchQueue.concurrentPerform(iterations: numberOfBatches) { (batchNumber) in
        let numberOfIntergersToCheck = n /  numberOfBatches //20000
        let lowerBound = batchNumber * numberOfIntergersToCheck
        let upperBound = lowerBound + numberOfIntergersToCheck
        
        var localResults: [Int] = []
        for number in lowerBound ..< upperBound {
            if isPrime(number) {
            localResults.append(number)
            }
        }
        lock.lock()
        primes.append(localResults)
        lock.unlock()
    }
    return primes
}
*/

