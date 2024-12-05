import Foundation

public struct Day3 {

    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day3")?.trimmingCharacters(in: .whitespaces)
        
        let matches = text!.matches(of: /(mul\()(\d{1,3})(,)(\d{1,3})(\))/ )
        let sum = matches.map {
            return Int($0.2)! * Int($0.4)!
        }
        .reduce(0, +)
            
        print("\(sum)")
    }
    
    public static func part2() {
        let text = Bundle.main.getInput(file: "input_day3")?.trimmingCharacters(in: .whitespaces)
        let matchesDo = text!.split(separator: "do()")
        
        let sum = Array(matchesDo).map{
            var onlyDo = String( $0 )
            
            if onlyDo.contains("don't()"){
                onlyDo = String( onlyDo.split(separator: "don't()").first ?? "")
            }
            
            let matchesMul = onlyDo.matches(of: /(mul\()(\d{1,3})(,)(\d{1,3})(\))/ )
            return matchesMul.map {
                return Int($0.2)! * Int($0.4)!
            }
            .reduce(0, +)
        }
        .reduce(0, +)
            
        print("\(sum)")
    }
}
