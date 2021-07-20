//
//  day23.swift
//  aoc2016
//
//  Created by Chris McElroy on 7/19/21.
//

import Foundation

func day23() {
	var input = inputWords(23)
 
	func run(key: Int) -> Int {
	 var line = 0
	 var registers: [String: Int] = ["a": 12, "b": 0, "c": key, "d": 0]
		var topLine = 0
		
	 while line < input.count {
		 let instr = input[line]
		if line > topLine { print("new top:", line, registers, instr); topLine = line }
		if line == 18 && registers["b"]! > 0 {
			registers["a"] = registers["a"]!*registers["b"]!
			registers["b"]! -= 1
			registers["c"] = registers["b"]!*2
			line -= 2
			print(registers, instr)
		} else {
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
			default: break
			}
			line += 1
		}
		 
	 }
	 
	 return registers["a"]!
 }
 
 let a1 = run(key: 0)
 
 print(a1)
}
