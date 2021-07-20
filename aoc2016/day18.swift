//
//  day18.swift
//  aoc2016
//
//  Created by Chris McElroy on 7/13/21.
//

import Foundation

func day18() {
	let input = inputLines(18)[0]
	var row: [Bool] = []
	var count = 0
	for c in input {
		row.append(c == "^")
	}
	for _ in 0..<400000 {
		var nextRow: [Bool] = []
		for i in 0..<row.count {
			if !row[i] { count += 1 }
			let left = i != 0 ? row[i-1] : false
			let right = i != row.count - 1 ? row[i+1] : false
			nextRow.append(right != left)
		}
		row = nextRow
	}
	
	print(count)
}
// 1951 20002936
// in: 18.827705025672913
