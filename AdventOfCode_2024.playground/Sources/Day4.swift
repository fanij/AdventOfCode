import Foundation

public struct Day4 {

    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day4")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n")
        
        let horizontal = lines.map{
            return ($0).ranges(of: "XMAS").count + ($0).ranges(of:"SAMX").count
        }
        .reduce(0, +)
        
        let vertical = findVertical(lines: lines.map{ String($0) })
        
        var diagonalLeft = [String]()
        var diagonalRight = [String]()
        
        for (index, object) in lines.enumerated(){
            let dot = String(repeating: ".", count: index)
            let dotEnd = String(repeating: ".", count: lines.count - index - 1)
            diagonalLeft.append(dot + object + dotEnd)
            diagonalRight.append(dotEnd + object + dot)
        }
        let diagonalL = findVertical(lines: diagonalLeft)
        let diagonalR = findVertical(lines: diagonalRight)
        
        print("\(horizontal + vertical + diagonalL + diagonalR)")
    }
    
    static func findVertical(lines:[String]) -> Int{
        var vertical = 0
        for c in 0..<lines[0].count{
            var column = ""
            for r in 0..<lines.count{
                column.append(Array(lines[r])[c])
            }
            vertical += column.ranges(of: "XMAS").count + column.ranges(of:"SAMX").count
        }
        return vertical
    }
}
