import Foundation

public struct Day4 {

    public static func part1() -> Int{
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
        
        return horizontal + vertical + diagonalL + diagonalR
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
    
    public static func part2() -> Int{
        let text = Bundle.main.getInput(file: "input_day4")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n").map{ Array($0) }
        
        var counter = 0
        for i in 1..<(lines.count - 1){
            let indexesOfA = lines[i].enumerated().compactMap{
                $0.element == "A" ? $0.offset : nil
            }
            
            for index in indexesOfA{
                if index > 0 && index < lines[i].count - 1{
                    let prevLine = lines[i-1]
                    let nextLine = lines[i+1]
                    if prevLine[index-1] == "M" && prevLine[index+1] == "S"
                        && nextLine[index-1] == "M" && nextLine[index+1] == "S"
                    {
                        counter += 1
                    }
                    else if prevLine[index-1] == "S" && prevLine[index+1] == "M"
                                && nextLine[index-1] == "S" && nextLine[index+1] == "M"
                    {
                        counter += 1
                    }
                    else if prevLine[index-1] == "S" && prevLine[index+1] == "S"
                                && nextLine[index-1] == "M" && nextLine[index+1] == "M"
                    {
                        counter += 1
                    }
                    else if prevLine[index-1] == "M" && prevLine[index+1] == "M"
                                && nextLine[index-1] == "S" && nextLine[index+1] == "S"
                    {
                        counter += 1
                    }
                }
            }
        }
        
        return counter
    }
}
