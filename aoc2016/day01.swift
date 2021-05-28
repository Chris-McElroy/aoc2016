//
//  day01.swift
//  aoc2016
//
//  Created by Chris McElroy on 5/17/21.
//

import Foundation

func day01() {
    let input = inputWords(1)[0]
    var path: [C2] = [C2(0, 0)]
    var dir = C2(0, 1)
    
    var a2 = -1
    
    for ins in input {
        dir.rotate(left: ins[0] == "L")
        
        let len = Int(ins.dropFirst().filter({ $0 != "," }))!
        
        for _ in 0..<len {
            let newPoint = path.last! + dir
            if a2 < 0 {
                if path.contains(newPoint) {
                    a2 = newPoint.manhattanDistance()
                }
            }
            path.append(newPoint)
        }
    }
    
    let a1 = path.last!.manhattanDistance()
    
    print(a1, a2)
}
// 299 181
