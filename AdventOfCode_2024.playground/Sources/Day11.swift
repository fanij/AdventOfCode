import Foundation

public struct Day11 {
    
    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day11")?.trimmingCharacters(in: .whitespaces)
        let line = text!.split(separator: "\n").first
        var numbers = String(line!).split(separator: " ").map{ String($0) }
        
        let blinks = 25
        
        for _ in 0..<blinks{
            var transformed = [String]()
            for number in numbers{
                if Int(number) == 0 {
                    transformed.append("1")
                }
                else if number.count % 2 == 0{
                    var number = number
                    let halfLength = number.count / 2
                    let index = number.index(number.startIndex, offsetBy: halfLength)
                    number.insert("-", at: index)
                    let result = number.split(separator: "-").map{ "\( Int($0) ?? 0 )" }
                    
                    transformed.append(result[0])
                    transformed.append(result[1])
                }
                else{
                    transformed.append("\( Int(number)! * 2024)")
                }
            }
            numbers = transformed
        }
        
        print(numbers.count)
    }
}
