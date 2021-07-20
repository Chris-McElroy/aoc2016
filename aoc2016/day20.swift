//
//  day20.swift
//  aoc2016
//
//  Created by Chris McElroy on 7/15/21.
//

import Foundation

func day20() {
	let input = inputLines(20)
	var blacklist: [[Int]] = input.map { $0.split(separator: "-").map({ Int($0)! }) }.sorted(by: { $0[0] < $1[0] })
	var lowest = 0
	var allowed = 0
	for r in blacklist { // where r[0] <= lowest {
		if lowest < r[0] { allowed += r[0] - lowest }
		lowest = max(r[1] + 1, lowest)
	}
	
	print(lowest, allowed)
} // 23923783 125
