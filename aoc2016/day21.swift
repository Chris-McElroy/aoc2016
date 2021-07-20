//
//  day21.swift
//  aoc2016
//
//  Created by Chris McElroy on 7/16/21.
//

import Foundation

func day21() {
	let input = inputWords(21)
	
	var password = "fbgdceah"
	
	for line in input.reversed() {
		print(password, line)
		if line[0] == "swap" {
			if line[1] == "position" {
				let x = min(Int(line[2])!, Int(line[5])!)
				let y = max(Int(line[2])!, Int(line[5])!)
				password = String(password.first(x)) + String(password[y]) + String(password[x+1,y]) + String(password[x]) + String(password.dropFirst(y+1))
			} else {
				let x = line[2][0]
				let y = line[5][0]
				password = String(password.map { $0 == x ? y : $0 == y ? x : $0 })
			}
		} else if line[0] == "rotate" {
			if line[1] == "right" {
				let d = Int(line[2])!
				password = String(password.dropFirst(d) + password.first(d))
			} else if line[1] == "left" {
				let d = Int(line[2])!
				password = String(password.last(d) + password.dropLast(d))
			} else {
				print("based", password, line)
				for j in 0...7 {
					let newP = String(password.dropFirst(j) + password.first(j))
					
					print("was", newP)
					
					let i = newP.firstIndex(of: line[6][0])!.utf16Offset(in: newP)
					let d = (i >= 4 ? i + 2 : i + 1) % newP.count
					if password == String(newP.last(d) + newP.dropLast(d)) {
						print("yes")
						password = newP
						break
					}
				}
			}
		} else if line[0] == "reverse" {
			let x = Int(line[2])!
			let y = Int(line[4])!
			password = String(password.first(x) + password[x,y+1].reversed() + password.dropFirst(y+1))
		} else if line[0] == "move" {
			let x = Int(line[2])!
			let y = Int(line[5])!
			let c = password[y]
			password = password.filter { $0 != c }
			password.insert(c, at: password.index(password.startIndex, offsetBy: x))
		}
	}
	
	print(password)
}
// baecdfgh part 1
// habcgedf wrong efbchagd wrong
