//
//  helpers.swift
//  aoc2016
//
//  Created by Chris McElroy on 5/17/21.
//

import Foundation

// input functions //

public func inputLines(_ num: Int) -> [String] {
    do {
        let home = FileManager.default.homeDirectoryForCurrentUser
        let name = "input" + (num < 10 ? "0" : "") + "\(num)"
        let filePath = projectFolder + "/aoc2016/input/" + name
        let file = URL(fileURLWithPath: filePath, relativeTo: home)
        return try String(contentsOf: file).fullSplit(separator: "\n")
    } catch {
        print("Error: bad file name")
        return []
    }
}

public func inputInts(_ num: Int) -> [Int] {
    let input = inputLines(num)
    return input.map { Int($0) ?? 0 }
}

public func inputWords(_ num: Int) -> [[String]] {
    let input = inputLines(num)
    return input.map { $0.fullSplit(separator: " ") }
}

// shortcuts //

public extension Collection where Indices.Iterator.Element == Index {
    subscript(w i: Int?) -> Iterator.Element? {
        guard let j = i else { return nil }
        return self[index(startIndex, offsetBy: j % count)]
    }
    
    func first(_ k: Int) -> Self.SubSequence {
        return self.dropLast(count-k)
    }
    
    func last(_ k: Int) -> SubSequence {
        return self.dropFirst(count-k)
    }
    
    func slice(start: Int, len: Int) -> SubSequence {
        return self.first(start+len).dropFirst(start)
    }
    
    subscript(_ s: Int, _ e: Int) -> SubSequence {
        return self.first(e).dropFirst(s)
    }
    
    func each(_ k: Int) -> Array<SubSequence> {
        var array: Array<SubSequence> = []
        var i = 0
        while i < count {
            array.append(slice(start: i, len: Swift.min(k, count-i)))
            i += k
        }
        return array
    }
}

public extension Collection where Element: Equatable {
    func repeats(of e: Element) -> Int {
        return self.filter({ $0 == e }).count
    }
}

public extension Collection where Element: Hashable {
    func occurs(min: Int) -> Array<Element> {
        var counts: Dictionary<Element, Int> = [:]
        self.forEach { counts[$0, default: 0] += 1 }
        return Array(counts.filter { $0.value >= min }.keys)
    }
}

public extension Collection where Element: Numeric {
    func product() -> Element {
        return self.reduce(1) { x,y in x*y }
    }
    
    func sum() -> Element {
        return self.reduce(0) { x,y in x+y }
    }
}

public extension Collection where Element: AdditiveArithmetic {
    func twoSumTo(_ s: Element) -> [Element]? {
        guard let x = first(where: { contains(s-$0) }) else { return nil }
        return [x, s-x]
    }
    
    func nSumTo(_ s: Element, n: Int) -> [Element]? {
        if n == 2 { return twoSumTo(s) }
        for e in self {
            if var arr = nSumTo(s-e, n: n-1) {
                arr.append(e)
                return arr
            }
        }
        return nil
    }
}

public extension Array {
    subscript(w i: Int) -> Iterator.Element? {
        return self[index(startIndex, offsetBy: i % count)]
    }
    
    subscript(s i: Int) -> Iterator.Element? {
        if i < 0 || i >= count { return nil }
        return self[i]
    }
    
    func first(_ k: Int) -> Self.SubSequence {
        return self.dropLast(count-k)
    }
    
    func last(_ k: Int) -> Self.SubSequence {
        return self.dropFirst(count-k)
    }
    
    func slice(from start: Int, to end: Int, by k: Int) -> Self {
        let newSlice = slice(from: start, to: end)
        return newSlice.enumerated().compactMap { i,e in i.isMultiple(of: k) ? e : nil }
    }
    
    func slice(from start: Int, to end: Int) -> Self.SubSequence {
        return self.first(start+end).dropFirst(start)
    }
    
    func slice(from start: Int, through end: Int, by k: Int) -> Self {
        return slice(from: start, to: end+1, by: k)
    }
    
    func slice(from start: Int, through end: Int) -> Self.SubSequence {
        return self.slice(from: start, to: end+1)
    }
    
    subscript(_ s: Int, _ e: Int) -> Self.SubSequence {
        return self.first(e).dropFirst(s)
    }
    
    mutating func pushOn(_ new: Element) {
        self = self.dropFirst() + [new]
    }
}

public extension Array where Element: Equatable {
    func fullSplit(separator: Element) -> Array<Self> {
        return self.split(whereSeparator: { $0 == separator}).map { Self($0) }
    }
}

public extension String {
    func fullSplit(separator: Character) -> [String] {
        let s = self.split(separator: separator, maxSplits: .max, omittingEmptySubsequences: false).map { String($0) }
        if s.last == "" {
            return s.dropLast(1)
        } else {
            return s
        }
    }
    
    func occurs(min: Int) -> String {
        var counts: Dictionary<Character, Int> = [:]
        self.forEach { counts[$0, default: 0] += 1 }
        return String(counts.filter { $0.value >= min }.keys)
    }
    
    subscript(w i: Int) -> Character? {
        return self[index(startIndex, offsetBy: i % count)]
    }
    
    subscript(s i: Int) -> Character? {
        if i < 0 || i >= count { return nil }
        return self[i]
    }
    
    func slice(from start: Int, to end: Int, by k: Int) -> Self {
        let newSlice = slice(from: start, to: end)
        return String(newSlice.enumerated().compactMap { i,e in i.isMultiple(of: k) ? e : nil })
    }
    
    func slice(from start: Int, through end: Int, by k: Int) -> Self {
        return slice(from: start, to: end+1, by: k)
    }
}

public extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    
    subscript(_ s: Int, _ e: Int) -> SubSequence {
        return self.first(e).dropFirst(s)
    }
    
    func first(_ k: Int) -> Self.SubSequence {
        return self.dropLast(count-k)
    }
    
    func last(_ k: Int) -> Self.SubSequence {
        return self.dropFirst(count-k)
    }
    
    func slice(from start: Int, through end: Int) -> Self.SubSequence {
        return self.slice(from: start, to: end+1)
    }
    
    func slice(from start: Int, to end: Int) -> Self.SubSequence {
        return self.first(start+end).dropFirst(start)
    }
    
    func isin(_ string: Self?) -> Bool {
        return string?.contains(self) == true
    }
}

extension RangeReplaceableCollection {
    // from https://stackoverflow.com/questions/25162500/apple-swift-generate-combinations-with-repetition
    // I should use rangereplacablecollection for everything i think
    func combinations(of n: Int) -> [SubSequence] {
        guard n > 0 else { return [.init()] }
        guard let first = first else { return [] }
        return combinations(of: n - 1).map { CollectionOfOne(first) + $0 } + dropFirst().combinations(of: n)
    }
    func uniqueCombinations(of n: Int) -> [SubSequence] {
        guard n > 0 else { return [.init()] }
        guard let first = first else { return [] }
        return dropFirst().uniqueCombinations(of: n - 1).map { CollectionOfOne(first) + $0 } + dropFirst().uniqueCombinations(of: n)
    }
}

// permutations from https://stackoverflow.com/questions/34968470/calculate-all-permutations-of-a-string-in-swift
func permutations<T>(len n: Int, _ a: inout [T], output: inout [[T]]) {
    if n == 1 { output.append(a); return }
    for i in stride(from: 0, to: n, by: 1) {
        permutations(len: n-1, &a, output: &output)
        a.swapAt(n-1, (n%2 == 1) ? 0 : i)
    }
}

public extension Comparable {
    func isin(_ collection: Array<Self>?) -> Bool {
        return collection?.contains(self) == true
    }
    
    mutating func swap(_ x: Self, _ y: Self) {
        self = (self == x) ? y : x
    }
}

public extension Equatable {
    func isin(_ one: Self, _ two: Self, _ three: Self) -> Bool {
        return self == one || self == two || self == three
    }
}

public extension Hashable {
    func isin(_ collection: Set<Self>?) -> Bool {
        return collection?.contains(self) == true
    }
}

public extension Character {
    func isin(_ string: String?) -> Bool {
        return string?.contains(self) == true
    }
}

public extension Numeric where Self: Comparable {
    func isin(_ range: ClosedRange<Self>?) -> Bool {
        return range?.contains(self) == true
    }
    
    func isin(_ range: Range<Self>?) -> Bool {
        return range?.contains(self) == true
    }
}

infix operator ** : MultiplicationPrecedence
public extension Numeric {
    func sqrd() -> Self {
        self*self
    }
    
    static func ** (lhs: Self, rhs: Int) -> Self {
        (0..<rhs).reduce(1) { x,y in x*lhs }
    }
}

public extension Bool {
    var int: Int { self ? 1 : 0 }
}

func timed(_ run: () -> Void) {
    let start = Date().timeIntervalSinceReferenceDate
    run()
    let end = Date().timeIntervalSinceReferenceDate
    print("in:", end-start)
}

public extension BinaryFloatingPoint {
    var isWhole: Bool { self.truncatingRemainder(dividingBy: 1) == 0 }
    var isEven: Bool { Int(self) % 2 == 0 }
    var isOdd: Bool { Int(self) % 2 == 1 }
    var int: Int? { isWhole ? Int(self) : nil }
}

public extension BinaryInteger {
    var isEven: Bool { self % 2 == 0 }
    var isOdd: Bool { self % 2 == 1 }
}

struct C2: Equatable, Hashable, AdditiveArithmetic {
    var x: Int
    var y: Int
    
    static var zero: C2 = C2(x: 0, y: 0)
    
    mutating func rotateLeft() {
        let tempX = x
        x = -y
        y = tempX
    }
    
    mutating func rotateRight() {
        let tempX = x
        x = y
        y = -tempX
    }
    
    mutating func rotate(left: Bool) {
        left ? rotateLeft() : rotateRight()
    }
    
    func length() -> Int {
        abs(x) + abs(y)
    }
    
    static func + (lhs: C2, rhs: C2) -> C2 {
        C2(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func - (lhs: C2, rhs: C2) -> C2 {
        C2(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
