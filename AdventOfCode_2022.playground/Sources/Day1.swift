import Foundation

public struct Day1 {

    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day1")?.trimmingCharacters(in: .whitespaces)
        let max = text?.split(separator: "\n\n")
            .map{
                let sum = ($0).split(separator: "\n").compactMap{ Int($0) }.reduce(0, +)
                return sum
            }
            .max { $0 < $1 }
        
        print("\(max ?? 0)")
    }
    
    public static func part2() {
        let text = Bundle.main.getInput(file: "input_day1")?.trimmingCharacters(in: .whitespaces)
        let max = text?.components(separatedBy: "\n\n")
            .map{
                let sum = ($0).components(separatedBy: "\n").compactMap{ Int($0) }.reduce(0, +)
                return sum
            }
            .sorted().suffix(3).reduce(0, +)
        
        print("\(max ?? 0)")
    }
}
