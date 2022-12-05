import Foundation

public struct Day3 {

    static func priority(char:Character) -> Int{
        let startChar = Int(Character(char.isLowercase ? "a" : "A").asciiValue!)
        let lastIndex = Int(char.asciiValue!)
        let startPoint = lastIndex - startChar
        return (char.isLowercase ? 1 : 27) + startPoint
    }
    
    static func sameChars(rucksack: String) -> Set<Character>{
        let len = rucksack.count / 2
        let l1 = rucksack.prefix(len)
        let l2 = rucksack.suffix(len)
        return Set(l1).intersection(Set(l2))
    }
    
    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day3")?.trimmingCharacters(in: .whitespaces)
        var sum = 0
        if let rucksacks = text?.split(separator: "\n"){
            for ru in rucksacks {
                let same = sameChars(rucksack: String(ru))
                let res = same.map{
                    priority(char: $0)
                }.reduce(0, +)
                sum += res
            }
        }
        print(sum)
    }
    
    public static func part2() {
        let text = Bundle.main.getInput(file: "input_day3")?.trimmingCharacters(in: .whitespaces)
        var sum = 0
        
        let rucksacks = text?.split(separator: "\n") ?? []
        stride(from: 0, to: rucksacks.count, by: 3).forEach { i in
            let l1 = rucksacks[i]
            let l2 = rucksacks[i+1]
            let l3 = rucksacks[i+2]
            let same = Set(l1).intersection(Set(l2)).intersection(Set(l3))
            let res = same.map{
                priority(char: $0)
            }.reduce(0, +)
            sum += res
        }
        
        print(sum)
    }
}
