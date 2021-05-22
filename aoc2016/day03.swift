//
//  day03.swift
//  aoc2016
//
//  Created by Chris McElroy on 5/19/21.
//

import Foundation

func day03() {
    let input = inputWords(3)
    var columns: [[Int]] = [[],[],[]]
    var a1 = 0
    var a2 = 0
    
    func possible(_ lengths: [Int]) -> Bool {
        lengths.sum() - lengths.max()! > lengths.max()!
    }
    
    for line in input {
        var row: [Int] = []
        for word in line.filter({ $0 != "" }) {
            row.append(Int(word)!)
        }
        a1 += possible(row).int
        
        for i in 0...2 { columns[i].append(row[i]) }
        if columns[0].count == 3 {
            for i in 0...2 { a2 += possible(columns[i]).int }
            columns = [[],[],[]]
        }
    }
    
    print(a1, a2)
} // 983 1836
