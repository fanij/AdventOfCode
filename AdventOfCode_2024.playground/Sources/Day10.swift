import Foundation

public struct Day10 {
    
    public static func part1() -> Int {
        let text = Bundle.main.getInput(file: "input_day10")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n")
            .map{ String($0).split(separator: "").map({ Int($0)! }) }
        
        var score = [Point : Set<Point>]()
        
        var zeros = [Point]()
        for (index, line) in lines.enumerated(){
            let z = line.enumerated().compactMap {
                if ( $0.element == 0) {
                    return Point(x: index, y: $0.offset)
                }
                return nil
            }
            zeros.append(contentsOf: z)
        }
        
        for start in zeros{
            var points = [start]
            
            while( !points.isEmpty ){
                if let last = points.last{
                    points.removeLast()
                    let moved = move(point: last, lines: lines)
                    let end = moved.filter{ lines[$0.x][$0.y] == 9 }
                    if end.count > 0 {
                        for e in end{
                            score[start, default: [] ].insert(e)
                        }
                    }
                    points.append(contentsOf: moved)
                }
            }
        }
        
        let result = score.map { (key: Point, value: Set<Point>) in
            return value.count
        }.reduce(0, +)
        
        return result
    }
    
    public static func part2() -> Int {
        let text = Bundle.main.getInput(file: "input_day10")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n")
            .map{ String($0).split(separator: "").map({ Int($0)! }) }
        
        var score = [Point : Int]()
        
        var zeros = [Point]()
        for (index, line) in lines.enumerated(){
            let z = line.enumerated().compactMap {
                if ( $0.element == 0) {
                    return Point(x: index, y: $0.offset)
                }
                return nil
            }
            zeros.append(contentsOf: z)
        }
        
        for start in zeros{
            var points = [start]
            var rating = [Point : Int]()
            
            while( !points.isEmpty ){
                if let last = points.last{
                    points.removeLast()
                    let moved = move(point: last, lines: lines)
                    let end = moved.filter{ lines[$0.x][$0.y] == 9 }
                    if end.count > 0 {
                        for e in end{
                            rating[e, default: 0] += 1
                        }
                    }
                    points.append(contentsOf: moved)
                }
            }
            score[start, default: 0] = rating.map { (key: Point, value: Int) in
                return value
            }.reduce(0, +)
        }
        
        let result = score.map { (key: Point, value: Int) in
            return value
        }.reduce(0, +)
        
        return result
    }
    
    static func move(point:Point, lines:[[Int]]) -> [Point] {
        var points = [Point]()
        if var value = lines[safe: point.x]?[safe: point.y] {
            value += 1
            if lines[safe: point.x]?[safe: point.y + 1] == value{
                points.append(Point(x: point.x, y: point.y + 1))
            }
            if lines[safe: point.x]?[safe: point.y - 1] == value{
                points.append(Point(x: point.x, y: point.y - 1))
            }
            if lines[safe: point.x + 1]?[safe: point.y] == value{
                points.append(Point(x: point.x + 1, y: point.y))
            }
            if lines[safe: point.x - 1]?[safe: point.y] == value{
                points.append(Point(x: point.x - 1, y: point.y))
            }
        }
        return points
    }
}
