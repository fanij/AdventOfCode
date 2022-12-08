import Foundation

public struct Day6 {
    
    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day6") ?? ""
        let result = findMarker(text: text, len: 4)
        print(result)
    }
    
    public static func part2() {
        let text = Bundle.main.getInput(file: "input_day6") ?? ""
        let result = findMarker(text: text, len: 14)
        print(result)
    }
    
    static func findMarker(text: String, len: Int) -> Int{
        for (index, i) in Array(text).enumerated() {
            if Set(text.prefix(index).suffix(len)).count == len {
                return index
            }
        }
        return 0
    }
}
