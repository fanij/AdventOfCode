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
    
    public static func part2() {
        let text = Bundle.main.getInput(file: "input_day11")?.trimmingCharacters(in: .whitespaces)
        let line = text!.split(separator: "\n").first
        let numbers = String(line!).split(separator: " ").map{ Int($0)! }
        
        let blinks = 75
        var dict:[Int : Int] = Dictionary(grouping: numbers, by: { $0 }).mapValues(\.count)
        
        for _ in 0..<blinks{
            var newStones = [Int : Int]()
            
            newStones[1] = dict[0]
            
            var keys = dict.keys.filter { $0 != 0 }
            let indexes = keys.partition { "\($0)".count % 2 == 0 }
            
            for key in keys[0 ..< indexes] {
                newStones[key*2024] = dict[key]
            }
            
            for key in keys[indexes ..< keys.count] {
                var number = "\(key)"
                let halfLength = number.count / 2
                let index = number.index(number.startIndex, offsetBy: halfLength)
                number.insert("-", at: index)
                let result = number.split(separator: "-").map{ Int($0) ?? 0 }
                
                newStones[result[0], default: 0] += dict[key] ?? 0
                newStones[result[1], default: 0] += dict[key] ?? 0
            }
            
            dict = newStones
        }
        
        print( dict.values.reduce(0, +))
    }
}
