//
//  day10.swift
//  aoc2016
//
//  Created by Chris McElroy on 6/5/21.
//

import Foundation

func day10() {
    struct Output {
        let n: Int
        let bot: Bool
    }
    
    class Bot {
        let id: Int
        var chips: [Int] = []
        let lowOutput: Output
        let highOutput: Output
        
        init(id: Int, low: Output, high: Output) {
            self.id = id
            lowOutput = low
            highOutput = high
        }
    }
    
    let input = inputWords(10)
    var bots: [Int: Bot] = [:]
    var outputs: [Int: Int] = [:]
    
    var a1 = 0
    
    for line in input where line.first == "bot" {
        let lowOut = Output(n: Int(line[6])!, bot: line[5] == "bot")
        let highOut = Output(n: Int(line[11])!, bot: line[10] == "bot")
        let bot = Bot(id: Int(line[1])!, low: lowOut, high: highOut)
        bots[bot.id] = bot
    }
    
    for line in input where line.first == "value" {
        bots[Int(line[5])!]?.chips.append(Int(line[1])!)
    }
    
    while let bot = bots.first(where: { $0.value.chips.count == 2 }) {
        let bot = bot.value
        let low = bot.chips.min()!
        let high = bot.chips.max()!
        bot.chips = []
        
        if low == 17 && high == 61 {
            a1 = bot.id
        }
        
        if bot.lowOutput.bot {
            bots[bot.lowOutput.n]?.chips.append(low)
        } else {
            outputs[bot.lowOutput.n, default: 0] = low
        }
        
        if bot.highOutput.bot {
            bots[bot.highOutput.n]?.chips.append(high)
        } else {
            outputs[bot.highOutput.n, default: 0] = high
        }
    }
    
    let a2 = outputs.filter({ $0.key.isin(0...2) }).values.product()
    
    print(a1, a2)
}
// 157 1085
