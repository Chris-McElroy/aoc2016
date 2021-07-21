//
//  day24.swift
//  aoc2016
//
//  Created by Chris McElroy on 7/20/21.
//

import Foundation

func day24() {
	let input = inputLines(24)
	
	struct State: Hashable {
		var seen: Set<Int>
		var pos: C2
	}
	
	let startX = input.first(where: { $0.contains("0") })!.firstIndex(of: "0")!.utf16Offset(in: input[0])
	let startY = input.enumerated().first(where: { $0.element.contains("0") })!.offset
	
	bfs(for: { state, steps, _ in
		if (state.seen.count == 8) && state.pos == C2(startX, startY) {
			print(state, steps)
			return true
		}
		return false
	}, from: [State(seen: [0], pos: C2(startX, startY))], with: { state in
		var nextStates: [State] = []
		for loc in state.pos.adjacents {
			var newState = state
			newState.pos = loc
			if input[loc.y][loc.x] != "#" {
				if input[loc.y][loc.x] != "." {
					newState.seen.insert(Int(String(input[loc.y][loc.x]))!)
				}
				nextStates.append(newState)
			}
		}
		return nextStates
	}, while: { len, _ in len < 10000 })
}
// 250 too low
