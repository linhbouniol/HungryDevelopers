//: Playground - noun: a place where people can play

import Cocoa

class Spoon {
    
//    var spoonIsPickedUp: Bool = false

    var index: Int
    
    init(index: Int) { // initialize because you dont want to give it a default value right away
        self.index = index
    }
    
    private let lock = NSLock()
    
    func pickUp() {
        // If spoon is picked up, we wait for the spoon to be put down before picking it up
        // else we pick up the spoon
        
        // You want to claim the rights to the spoon and you do so with the lock, then you pick up the spoon.
        // Only when you put down the spoon, that you relinquish the lock
        
        lock.lock()
//        spoonIsPickedUp = true
    }
    
    func putDown() {
    
//        spoonIsPickedUp = false
        lock.unlock()
    }
}

class Developer {
    
    var name: String    // something to call the developer by
    var leftSpoon: Spoon
    var rightSpoon: Spoon
    
    init(name: String, leftSpoon: Spoon, rightSpoon: Spoon) {
        self.name = name
        self.leftSpoon = leftSpoon
        self.rightSpoon = rightSpoon
    }
    
    func think() {
        // Think until leftSpoon is available, when it is, pick it up       -> spoon available means spoon isn't picked up?
        // Think until rightSpoon is available, when it is, pick it up
        
//        print("\(name) is picking up spoons")
//        leftSpoon.pickUp()
//        print("\(name) picked up left spoon")
//        rightSpoon.pickUp()
//        print("\(name) picked up right spoon")
        
        if leftSpoon.index < rightSpoon.index {
            leftSpoon.pickUp()
//            print("\(name) picked up left spoon")
            rightSpoon.pickUp()
//            print("\(name) picked up right spoon")
        } else {
            rightSpoon.pickUp()
//            print("\(name) picked up right spoon")
            leftSpoon.pickUp()
//            print("\(name) picked up left spoon")
        }
    }
    
    func eat() {
        /*
         Micro = 1_000_000, drand48() gives a random number between 0 and 1
         We want to wait between 0 and 10 seconds: 10 * drand48 * 1_000_000
        */
        print("\(name) is going to eat")
        let randomSecond = UInt32(3 * drand48() * 1_000_000)
        
        // Wait some seconds then put down rightSpoon, then leftSpoon
        usleep(randomSecond)
        
        print("\(name) is finished eating")
        rightSpoon.putDown()
        leftSpoon.putDown()
    }
    
    func run() {
        while true {    // true is always true, so the loop will repeat forever
            think()
            eat()
        }
    }
}

// Create 5 spoons and 5 developers

var spoon1 = Spoon(index: 1)
var spoon2 = Spoon(index: 2)
var spoon3 = Spoon(index: 3)
var spoon4 = Spoon(index: 4)
var spoon5 = Spoon(index: 5)

var developersArray = [Developer]()

var developer1 = Developer(name: "Developer1", leftSpoon: spoon5, rightSpoon: spoon1)
var developer2 = Developer(name: "Developer2", leftSpoon: spoon1, rightSpoon: spoon2)
var developer3 = Developer(name: "Developer3", leftSpoon: spoon2, rightSpoon: spoon3)
var developer4 = Developer(name: "Developer4", leftSpoon: spoon3, rightSpoon: spoon4)
var developer5 = Developer(name: "Developer5", leftSpoon: spoon4, rightSpoon: spoon5)

developersArray.append(developer1)
developersArray.append(developer2)
developersArray.append(developer3)
developersArray.append(developer4)
developersArray.append(developer5)

DispatchQueue.concurrentPerform(iterations: 5) {
    developersArray[$0].run()
}
