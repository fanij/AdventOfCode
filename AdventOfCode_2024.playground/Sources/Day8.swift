import Foundation

public struct Day8 {
    
    class Point: NSObject{
        var x:Int
        var y:Int
        
        init(x: Int, y: Int) {
            self.x = x
            self.y = y
        }
        
        func moveBy(_ other: Point) -> Point{
            let difx = self.x - other.x
            let dify = self.y - other.y
            return Point(x: self.x + difx, y: self.y + dify)
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            if let other = object as? Point {
                return self.x == other.x && self.y == other.y
            } else {
                return false
            }
        }
        
        override var hash: Int {
            return "\(self.x) - \(self.y)".hashValue
        }
    }
    
    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day8")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n").map{ String($0) }
        
        var antenasDic = [Character : [Point]]()
        
        for (x, line) in lines.enumerated(){
            for (y, char) in line.enumerated(){
                if char != "." {
                    let point = Point(x: x, y: y)
                    var list = antenasDic[char] ?? []
                    list.append(point)
                    antenasDic[char] = list
                }
            }
        }
        
        var antinodes = [Point]()
        let maxX = lines.count
        let maxY = lines.first?.count ?? 0
        
        for key in antenasDic.keys{
            let list = antenasDic[key] ?? []
            for i in 0..<list.count{
                for n in i+1..<list.count{
                    if let f = list[safe: i] , let s = list[safe: n] {
                        let fmove = f.moveBy(s)
                        if fmove.x >= 0 && fmove.x < maxX && fmove.y >= 0 && fmove.y < maxY{
                            if antenasDic.keys.compactMap({ antenasDic[$0]!.contains(fmove) ? $0 : nil }).count == 0{
                                antinodes.append(fmove)
                            }
                        }
                        
                        let smove = s.moveBy(f)
                        if smove.x >= 0 && smove.x < maxX && smove.y >= 0 && smove.y < maxY{
                            if antenasDic.keys.compactMap({ antenasDic[$0]!.contains(smove) ? $0 : nil }).count == 0{
                                antinodes.append(smove)
                            }
                        }
                    }
                }
            }
        }
        
        print(antinodes.count)
    }
}
