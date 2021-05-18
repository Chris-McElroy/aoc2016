//
//  day01.swift
//  aoc2016
//
//  Created by Chris McElroy on 5/17/21.
//

import Foundation

func day01() {
    let input = inputWords(1)[0]
    var path: [C2] = [C2(x: 0, y: 0)]
    var dir = C2(x: 0, y: 1)
    
    var a2 = -1
    
    for ins in input {
        dir.rotate(left: ins[0] == "L")
        
        let len = Int(ins.dropFirst().filter({ $0 != "," }))!
        
        for _ in 0..<len {
            let newPoint = path.last! + dir
            if a2 < 0 {
                if path.contains(newPoint) {
                    a2 = newPoint.length()
                }
            }
            path.append(newPoint)
        }
    }
    
    let a1 = path.last!.length()
    
    print(a1, a2)
}
// 299 181
