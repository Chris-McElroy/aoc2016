//
//  day19.swift
//  aoc2016
//
//  Created by Chris McElroy on 7/14/21.
//

import Foundation

func day19() {
	let input = inputInts(19)[0]
	
//	var s: [Int] = []
	for r in input...input {
//		var list = Array(1...r)
//
//		while list.count > 1 {
//			list.remove(at: list.count/2)
//			list.append(list.removeFirst())
//		}

		var i = 1
		while i*3 < r { i = i*3 }
		let c = (max(0,r-i*2)) + r-i
		
		print((r - (1 << (63 - r.leadingZeroBitCount))) << 1 + 1)
		
//		if c != list[0] {
			print(r, ":", c)
//		s += [c]
//		} else { print(r) }
	}
//	print(s)
	
} // 1417888 too high, literally off by one
// i would like to know why
// it's cuz i did it wron,g fixed now
