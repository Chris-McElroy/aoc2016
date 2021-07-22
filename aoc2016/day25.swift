//
//  day25.swift
//  aoc2016
//
//  Created by Chris McElroy on 7/21/21.
//

import Foundation

func day25() {
	var input = inputWords(25)
	
	func run(key: Int) -> Int {
	 var line = 0
	 var registers: [String: Int] = ["a": key, "b": 0, "c": 0, "d": 0]
//		var topLine = 0
		var lastOut = 1
		var numOut = 0
		
	 while line < input.count {
		 let instr = input[line]
//		if line > topLine { print("new top:", line, registers, instr); topLine = line }

			switch instr[0] {
			case "cpy":
			   if instr[2].isin("abcd") {
					if let n = Int(instr[1]) {
						registers[instr[2]] = n
				   } else if instr[1].isin("abcd") {
						registers[instr[2]] = registers[instr[1]]!
					}
					break
			   }
			case "jnz":
			   let test: Int
			   if Int(instr[1]) != nil { test = Int(instr[1])! }
			   else if instr[1].isin("abcd") { test = registers[instr[1]]! }
			   else { break }
			   let n: Int
			   if Int(instr[2]) != nil { n = Int(instr[2])! }
			   else if instr[2].isin("abcd") { n = registers[instr[2]]! }
			   else { break }
				if test != 0 {
					line += n - 1
				}
				break
			case "inc":
			   guard instr[1].isin("abcd") else { break }
				registers[instr[1]]! += 1
				break
			case "dec":
			   guard instr[1].isin("abcd") else { break }
				registers[instr[1]]! -= 1
				break
		   case "tgl":
			   guard let tglLine = registers[instr[1]], (tglLine+line).isin(0..<input.count) else { break }
			   if input[tglLine+line].count == 2 {
				   if input[tglLine+line][0] == "inc" {
					   input[tglLine+line][0] = "dec"
				   } else {
					   input[tglLine+line][0] = "inc"
				   }
			   } else {
				   if input[tglLine+line][0] == "jnz" {
					   input[tglLine+line][0] = "cpy"
				   } else {
					   input[tglLine+line][0] = "jnz"
				   }
			   }
			   break
			case "out":
				let out: Int
				if Int(instr[1]) != nil { out = Int(instr[1])! }
				else if instr[1].isin("abcd") { out = registers[instr[1]]! }
				else { break }
				if lastOut^1 == out {
					lastOut = out
					numOut += 1
				} else {
					return numOut
				}
				if numOut > 1000 { return numOut }
			default: break
			}
			line += 1
		}
		 
	 return numOut
 }
	var i = 1
	while run(key: i) < 1000 {
		i += 1
		print(i)
	}
	
	print(input)
}
