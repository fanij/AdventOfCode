import Foundation

public struct Day5 {
    
    struct Stack<T>:CustomStringConvertible{
        var items: [T] = []
        
        mutating func push(_ item:T){
            items.insert(item, at: 0)
        }
        
        mutating func push(_ itms:[T]){
            items.insert(contentsOf: itms, at: 0)
        }
        
        mutating func pop() -> T?{
            if items.isEmpty { return nil }
            return items.removeFirst()
        }
        
        mutating func pop(_ num:Int) -> [T]?{
            if items.isEmpty { return nil }
            let r = items[0..<num]
            items.removeFirst(num)
            return Array(r)
        }
        
        func peek() -> T? {
            return items.first
        }
        
        var description: String{
            "{" + items.map{"\($0)"}.joined(separator: ",") + "}"
        }
    }
    
    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day5") ?? ""
        let parts = text.split(separator: "\n\n").compactMap{ $0.split(separator: "\n") }
        let crates = parts.first
        let movesLines = parts.last
        
        var stacks = getStacks(lines: crates ?? [])
        let moves = getMoves(lines: movesLines ?? [])
        
        for mv in moves {
            for _ in 0..<mv.num {
                if let item = stacks[mv.from-1].pop(){
                    stacks[mv.to-1].push(item)
                }
            }
        }
        
        let top = stacks.compactMap{
            $0.peek()
        }
        
        print("\(String(top))")
    }
    
    public static func part2() {
        let text = Bundle.main.getInput(file: "input_day5") ?? ""
        let parts = text.split(separator: "\n\n").compactMap{ $0.split(separator: "\n") }
        let crates = parts.first
        let movesLines = parts.last
        
        var stacks = getStacks(lines: crates ?? [])
        let moves = getMoves(lines: movesLines ?? [])
        
        for mv in moves {
            if let items = stacks[mv.from-1].pop(mv.num){
                stacks[mv.to-1].push(items)
            }
        }
        
        let top = stacks.compactMap{
            $0.peek()
        }
        
        print("\(String(top))")
    }
    
    static func getStacks(lines: [String.SubSequence]) -> [Stack<Character>]{
        var crates = lines.map{ String($0) }
        let nums = crates.removeLast()
        
        let numberCrates = String(nums).replacingOccurrences(of: " ", with: "").count
        
        var stacks = [Stack<Character>](repeating: Stack<Character>(), count: numberCrates)
        
        for row in crates.reversed(){
            let chars = row.map { String($0) }
            for item in chars.enumerated(){
                let char = Character(item.element)
                if char.isLetter {
                    let stackIndex = (item.offset / 4)
                    stacks[stackIndex].push(char)
                }
            }
        }
        return stacks
    }
    
    static func getMoves(lines: [String.SubSequence]) -> [(num: Int, from: Int, to: Int)]{
        var moves = [(num: Int, from: Int, to: Int)]()
        for row in lines{
            var r = row.replacingOccurrences(of: "move ", with: "")
            r = r.replacingOccurrences(of: "from ", with: "")
            r = r.replacingOccurrences(of: "to ", with: "")
              
            let mvs = String(r).split(separator: " ").compactMap{ Int($0) }
            moves.append((num: mvs[0], from:mvs[1], to: mvs[2]))
        }
        return moves
    }
}
