import Foundation

public struct Day4 {
    
    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day4")?.trimmingCharacters(in: .whitespaces)
        let contain = text?.split(separator: "\n").map(getRange)
            .filter{
                $0[0].contains($0[1]) || $0[1].contains($0[0])
            }.count
        
        print("\(contain ?? 0)")
    }
    
    public static func part2() {
        let text = Bundle.main.getInput(file: "input_day4")?.trimmingCharacters(in: .whitespaces)
        let overlap = text?.split(separator: "\n").map(getRange)
            .filter{
                $0[0].overlaps($0[1])
            }
            .count
        
        print("\(overlap ?? 0)")
    }
    
    static func getRange(_ line: String.SubSequence) -> [ClosedRange<Int>]{
        return line.split(separator: ",")
            .map{
                let bounds = $0.split(separator: "-").compactMap{ Int(String($0)) }
                return ClosedRange<Int>(uncheckedBounds: (lower: bounds[0], upper: bounds[1]))
            }
    }
}
