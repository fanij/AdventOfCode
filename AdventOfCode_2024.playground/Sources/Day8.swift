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
        
        override var description: String{
            return "(\(x),\(y))"
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
                        if let fmove = createAntinode(p1:f, p2:s, maxX:maxX, maxY:maxY, antenas:antenasDic){
                            antinodes.append(fmove)
                        }
                        
                        if let smove = createAntinode(p1:s, p2:f, maxX:maxX, maxY:maxY, antenas:antenasDic){
                            antinodes.append(smove)
                        }
                    }
                }
            }
        }
        
        print(antinodes.count)
    }
    
    public static func part2() {
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
        
        var antinodes = Set<Point>()
        let maxX = lines.count
        let maxY = lines.first?.count ?? 0
        
        for key in antenasDic.keys{
            let list = antenasDic[key] ?? []
            for i in 0..<list.count{
                for n in i+1..<list.count{
                    if let f = list[safe: i] , let s = list[safe: n] {
                        var fmove: Point?
                        
                        antinodes.insert(f)
                        antinodes.insert(s)
                        
                        var p1 = f
                        var p2 = s
                        repeat{
                            fmove = createAntinode(p1:p1, p2:p2, maxX:maxX, maxY:maxY, antenas:[:])
                            if let fmove = fmove{
                                antinodes.insert(fmove)
                                p2 = p1
                                p1 = fmove
                            }
                        }while (fmove != nil)
                        
                        p1 = s
                        p2 = f
                        var smove: Point?
                        repeat{
                            smove = createAntinode(p1:p1, p2:p2 , maxX:maxX, maxY:maxY, antenas:[:])
                            if let smove = smove{
                                antinodes.insert(smove)
                                p2 = p1
                                p1 = smove
                            }
                        }while (smove != nil)
                    }
                }
            }
        }
        
        print(antinodes.count)
    }
    
    static func createAntinode(p1:Point, p2:Point, maxX:Int, maxY:Int, antenas:[Character : [Point]]) -> Point?{
        let move = p1.moveBy(p2)
        if move.x >= 0 && move.x < maxX && move.y >= 0 && move.y < maxY{
            if antenas.keys.compactMap({ antenas[$0]!.contains(move) ? $0 : nil }).count == 0{
                return move
            }
        }
        return nil
    }
}
