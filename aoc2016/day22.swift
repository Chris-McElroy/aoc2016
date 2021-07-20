//
//  day22.swift
//  aoc2016
//
//  Created by Chris McElroy on 7/19/21.
//

import Foundation

func day22() {
	let input = inputWords(22).dropFirst(2)
	
	struct Node: Hashable {
		let loc: C2
		let size: Int
		let avail: Int
		let used: Int
	}
	
	var nodes: Set<Node> = []
	
	for line in input {
		let l = line.filter({ $0 != "" })
		let x = Int(l[0].split(separator: "x")[1].split(separator: "-")[0])!
		let y = Int(l[0].split(separator: "y")[1])!
		let size = Int(l[1].dropLast())!
		let used = Int(l[2].dropLast())!
		let avail = Int(l[3].dropLast())!
		nodes.insert(Node(loc: C2(x,y), size: size, avail: avail, used: used))
	}
	
	var pairs = 0
	
	for node1 in nodes where node1.used != 0 {
		for node2 in nodes where node1 != node2 {
			if node1.used <= node2.avail {
				pairs += 1
			}
		}
	}
	
	print(pairs)
	var xs: [Int] = []
	
	for node in nodes {
		if node.avail > 66 { print(node) }
		if node.used > 80 { xs.append(node.loc.x) }
	}
	
	print(xs.sorted())
	print(7+28+32+33*5+1)
}
