//
//  day17.swift
//  aoc2016
//
//  Created by Chris McElroy on 7/12/21.
//

import Foundation

func day17() {
	let passcode = "mmsxrhfx"
	var count = 0
	bfs(for: { path, _, _ in
		var loc = C2(0,0)
		for c in path {
			switch c {
			case "D": loc.y += 1; break
			case "U": loc.y -= 1; break
			case "L": loc.x -= 1; break
			case "R": loc.x += 1; break
			default: break
			}
		}
		if loc == C2(3,3) {
			// print(path.count)
			count += 1
		}
		return false
	}, from: [""], with: { path in
		var loc = C2(0,0)
		for c in path {
			switch c {
			case "D": loc.y += 1; break
			case "U": loc.y -= 1; break
			case "L": loc.x -= 1; break
			case "R": loc.x += 1; break
			default: break
			}
		}
		if loc == C2(3,3) { return [] }
		let hash = MD5(of: passcode + path)
		
		var nextSteps: [String] = []
		for i in 0..<4 {
			if hash[i].isin("bcdef") {
				switch i {
				case 0: if loc.y > 0 { nextSteps.append(path + "U") }
				case 1: if loc.y < 3 { nextSteps.append(path + "D") }
				case 2: if loc.x > 0 { nextSteps.append(path + "L") }
				case 3: if loc.x < 3 { nextSteps.append(path + "R") }
				default: break
				}
			}
		}
		return nextSteps
	}, while: { n, paths in
		// print(paths.count)
		return n < 10000
	})
	print("ENDed:", count)
}
