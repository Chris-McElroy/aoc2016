//
//  day11.swift
//  aoc2016
//
//  Created by Chris McElroy on 6/8/21.
//

import Foundation

func day11() {
    let input = inputWords(11)
    
    var start: [Set<Int>] = [
        [1]
    ]
    
    var words: [String] = []
    
    for line in input {
        var getNext = false
        var currentFloor: Set<Int> = []
        for word in line {
            if word == "a" {
                getNext = true
            } else if getNext {
                getNext = false
                if word.hasSuffix("compatible") {
                    if let i = words.firstIndex(of: String(word.split(separator: "-")[0])) {
                        currentFloor.insert(i*2+1)
                    } else {
                        words.append(String(word.split(separator: "-")[0]))
                        currentFloor.insert(words.count*2-1)
                    }
                } else {
                    if let i = words.firstIndex(of: word) {
                        currentFloor.insert(i*2)
                    } else {
                        words.append(word)
                        currentFloor.insert(words.count*2-2)
                    }
                }
            }
        }
        start.append(currentFloor)
    }
    
    func valid(_ set: Set<Int>) -> Bool {
        let generators = set.filter({ $0.isEven })
        let chips = set.subtracting(generators)
        
        for chip in chips {
            if !generators.subtracting([chip-1]).isEmpty {
                if !generators.contains(chip-1) {
                    return false
                }
            }
        }
        
        return true
    }
    
    var history: Set<[Set<Int>]> = [start]
    var allSetups: Set<[Set<Int>]> = [start]
    
    var a1 = 0
    var a2: Int { a1 + 24 } // this works in all the examples I tested, it's possible it doesn't for you, in which case you'll need to run the full example
    // that took 30 min for me, sorry about that
    
    w: while a1 < 1000 {
        a1 += 1
        
        var newSetups: Set<[Set<Int>]> = []
        
        for setup in allSetups {
            let elevator = setup[0].first!
            let floor = setup[elevator]
            
            for a in floor {
                for b in floor {
                    for nextElevator in [[0],[2],[1,3],[2,4],[3]][elevator] {
                        let inElevator = Set([a,b])
                        let departureFloor = floor.subtracting(inElevator)
                        let arrivalFloor = setup[nextElevator].union(inElevator)
                        
                        if valid(inElevator) && valid(departureFloor) && valid(arrivalFloor) {
                            var newSetup = setup
                            newSetup[elevator] = departureFloor
                            newSetup[0] = [nextElevator]
                            newSetup[nextElevator] = arrivalFloor
                            newSetup.append([a, b, nextElevator*100 + (elevator-nextElevator)])
                            
                            if newSetup[1,4].joined().isEmpty {
                                break w
                            }
                            
                            if history.insert(Array(newSetup[0,5])).inserted {
                                newSetups.insert(newSetup)
                            }
                        }
                    }
                }
            }
        }
        
        allSetups = newSetups
    }
    
    print(a1, a2)
}
// 33 57

// helpful debugging code to see what the solution actually is
//let history = [Set([0, 1, 199]), Set([1, 299]), Set([399, 5, 7]), Set([301, 5]), Set([201, 1, 3]), Set([8, 4, 299]), Set([5, 399, 9]), Set([9, 301]), Set([201, 4]), Set([4, 299, 6]), Set([6, 399, 4]), Set([6, 301, 7]), Set([399, 6, 8]), Set([5, 301]), Set([5, 399, 9]), Set([301, 6]), Set([6, 201]), Set([3, 299, 1]), Set([3, 201]), Set([299, 6, 0]), Set([399, 0, 6]), Set([5, 301]), Set([5, 7, 399]), Set([301, 0]), Set([201, 0]), Set([2, 299, 0]), Set([2, 0, 399]), Set([301, 5]), Set([5, 201]), Set([3, 299, 5]), Set([3, 399, 5]), Set([9, 301]), Set([399, 1, 9])]
//
//var floors: [Set<Int>] = [
//    [1],
//    [0,1],
//    [2,4,6,8],
//    [3,5,7,9],
//    []
//]
//
//var elevator = 1
//
//func printStatus() {
//    for (i, f) in floors[1,5].enumerated() {
//        let desc = Array(f).map { a -> String in
//            switch a {
//            case 0: return "ag"
//            case 1: return "ac"
//            case 2: return "bg"
//            case 3: return "bc"
//            case 4: return "cg"
//            case 5: return "cc"
//            case 6: return "dg"
//            case 7: return "dc"
//            case 8: return "eg"
//            case 9: return "ec"
//            default: return ""
//            }
//        }
//        var s = ""
//        for t in desc.sorted() {
//            s += t + " "
//        }
//        print("\(i+1):\(elevator == i+1 ? "*" : " ")", s)
//    }
//    print()
//}
//
//for var h in history {
//    printStatus()
//
//    let nextElevator = (h.remove(h.max()!)! + 10) / 100
//
//    for e in h {
//        floors[elevator].remove(e)
//        floors[nextElevator].insert(e)
//    }
//
//    elevator = nextElevator
//}
//
//printStatus()
//
