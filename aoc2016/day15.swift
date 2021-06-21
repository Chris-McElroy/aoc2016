//
//  day15().swift
//  aoc2016
//
//  Created by Chris McElroy on 6/17/21.
//

import Foundation

func day15() {
    struct Disk {
        var pos: Int
        var offset: Int
    }
    
    let input = inputWords(15)
    
    let disks: [Disk] = input.map { Disk(pos: Int($0[3])!, offset: Int($0.last!.dropLast())!) }
    
    var factor = 1
    var offset = 1

    for (level, disk) in disks.enumerated() {
        for i in stride(from: 0, to: 10000, by: 1) {
            let t = factor*i + offset
            if (t + disk.offset + level + 1) % disk.pos == 0 {
                factor *= disk.pos
                offset = t
                break
            }
        }
    }
    
    let a1 = offset
    var a2 = 0
    
    for i in stride(from: 0, to: 10000, by: 1) {
        let t = factor*i + offset
        if (t + disks.count + 1) % 11 == 0 {
            a2 = t
            break
        }
    }
    
    print(a1, a2)
}
// 317371 2080951
