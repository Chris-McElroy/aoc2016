//
//  day13.swift
//  aoc2016
//
//  Created by Chris McElroy on 6/11/21.
//

import Foundation

func day13() {
    let input = inputInts(13)[0]
    
    var a1 = 0
    var a2 = 0
    
    func isOpen(_ c: C2) -> Bool {
        if c.x < 0 || c.y < 0 { return false }
        
        var n = c.x*c.x + 3*c.x + 2*c.x*c.y + c.y + c.y*c.y + input
        var ones = 0
        
        while n > 0 {
            ones += n % 2
            n = n/2
        }
        
        return ones % 2 == 0
    }
    
    bfs(startingWith: [C2(1, 1)], expandUsing: { $0.adjacents.filter(isOpen) }, continueWhile: {
        if $1.contains(C2(31, 39)) && a1 == 0 { a1 = $0 }
        if $0 == 50 { a2 = $1.count }

        return a1 == 0 || a2 == 0
    })
    
    print(a1, a2)
}
// 90 135
