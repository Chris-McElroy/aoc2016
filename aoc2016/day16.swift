//
//  day16.swift
//  aoc2016
//
//  Created by Chris McElroy on 7/9/21.
//

import Foundation

func day16() {
    var code = Array("10001001100000001")
    let len = 35651584

    while code.count < len {
        code = code + ["0"] + code.reversed().map({ $0 == "1" ? "0" : "1" })
        print(code.count)
    }
    
//    print(code)
    print("a")
    
    code = Array(code.first(len))
    
    var check = code
    repeat {
        var first: Character? = nil
        var newCheck: [Character] = []
        for c in check {
            if first == nil {
                first = c
            } else {
                newCheck.append(c == first ? "1" : "0")
                first = nil
            }
        }
        check = newCheck
    } while check.count.isEven
    
    print(String(check))
}

