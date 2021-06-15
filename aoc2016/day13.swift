//
//  day13.swift
//  aoc2016
//
//  Created by Chris McElroy on 6/11/21.
//

import Foundation

func day13() {
    let input = inputInts(13)[0]
    
    var history: Set<C2> = []
    var options: Set<C2> = [C2(1, 1)]
    var steps = 0
    
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
    
    while steps < 50 || !history.contains(C2(31, 39)) {
        steps += 1
        var newOptions: Set<C2> = []
        
        for var option in options {
            for adj in option.adjacents {
                if isOpen(adj) {
                    if history.insert(adj).inserted {
                        newOptions.insert(adj)
                    }
                }
            }
        }
        
        options = newOptions
        
        if history.contains(C2(31, 39)) && a1 == 0 { a1 = steps }
        if steps == 50 { a2 = history.count }
    }
    
    print(a1, a2)
}
