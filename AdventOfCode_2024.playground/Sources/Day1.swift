import Foundation

public struct Day1 {

    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day1")?.trimmingCharacters(in: .whitespaces)
        let lists = text?.split(separator: "\n")
            .flatMap{
                let values = ($0).split(separator: "   ").map{ Int($0)! }
                return values
            }
            .enumerated()
            .reduce(([Int](), [Int]())) { (value, object) -> ([Int], [Int]) in
                var value = value
                if object.offset % 2 == 0 {
                    value.0.append(object.element)
                } else {
                    value.1.append(object.element)
                }
                return value
            }
            
        let left = lists?.0.sorted() ?? []
        let right = lists?.1.sorted() ?? []
        
        let values = left.enumerated().map {
            return abs(right[$0.offset] - $0.element)
        }
            .reduce(0, +)
        
        print("\(values)")
    }
    
    public static func part2() {
        let text = Bundle.main.getInput(file: "input_day1")?.trimmingCharacters(in: .whitespaces)
        let lists = text?.split(separator: "\n")
            .flatMap{
                let values = ($0).split(separator: "   ").map{ Int($0)! }
                return values
            }
            .enumerated()
            .reduce(([Int](), [Int]())) { (value, object) -> ([Int], [Int]) in
                var value = value
                if object.offset % 2 == 0 {
                    value.0.append(object.element)
                } else {
                    value.1.append(object.element)
                }
                return value
            }
            
        let left = lists?.0
        let right = lists?.1
        
        let values = left?.enumerated().map {
            let val = $0.element
            let num = right?.filter{ val == $0 }.count ?? 0
            return num * val
        }
        .reduce(0, +)
        
        print("\(values)")
    }
}
