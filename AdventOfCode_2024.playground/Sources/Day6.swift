import Foundation

public struct Day6 {
    
    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day6")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n").map{ Array($0) }
        
        var guardLoc:Point?
        var obstacles = Set<Point>()
        
        for (x, line) in lines.enumerated(){
            for (y, char) in line.enumerated(){
                if char == "^"{
                    guardLoc = Point(x: x, y: y, direction: .up, maxX: lines.count, maxY: line.count)
                }
                else if char == "#"{
                    obstacles.insert(Point(x: x, y: y))
                }
            }
            guardLoc?.obstacles = obstacles
        }
        
        var moved = true
        var change = false
        while moved{
            (moved, change) = guardLoc?.move() ?? (false, false)
            if change {
                guardLoc?.directionChange()
                moved = true
            }
        }
        
        print(guardLoc?.visited.count ?? 0)
    }
    
    public static func part2() {
        let text = Bundle.main.getInput(file: "input_day6")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n").map{ Array($0) }
        
        var guardLoc:Point?
        var obstacles = Set<Point>()
        
        for (x, line) in lines.enumerated(){
            for (y, char) in line.enumerated(){
                if char == "^"{
                    guardLoc = Point(x: x, y: y, direction: .up, maxX: lines.count, maxY: line.count)
                }
                else if char == "#"{
                    obstacles.insert(Point(x: x, y: y))
                }
            }
            guardLoc?.obstacles = obstacles
        }
        
        var loops = 0
        
        if let guardLoc = guardLoc {
            for (x, line) in lines.enumerated(){
                for (y, _) in line.enumerated(){
                    let point = Point(x: x, y: y)
                    
                    if !obstacles.contains(point) && !(point.x == guardLoc.x && point.y == guardLoc.y){
                        if obstacles.map({ $0.x == x }).count > 0 || obstacles.map({ $0.y == y }).count > 0 {
                            
                            let guardC = guardLoc.copy() as! Day6.Point
                            guardC.obstacles.insert(point)
                            
                            var moved = true
                            var change = false
                            while moved{
                                (moved, change) = guardC.move()
                                if change {
                                    if let _ = point.visited.filter({
                                        $0.x == guardC.x &&
                                        $0.y == guardC.y &&
                                        $0.direction == guardC.direction
                                    }).first{
                                        
                                        moved = false
                                        loops += 1
                                        
                                        continue
                                    }
                                    
                                    point.visited.insert(Point(x: guardC.x, y: guardC.y, direction: guardC.direction))
                                    guardC.directionChange()
                                    moved = true
                                }
                            }
                        }
                    }
                }
            }
        }
        
        print(loops)
    }
}

extension Day6{
    enum Direction{
        case up
        case down
        case left
        case right
        
        init?(char: Character) {
            if char == "^" {
                self = .up
            } else if char == "V" {
                self = .down
            } else if char == "<"{
                self = .left
            } else if char == ">"{
                self = .right
            }else {
                return nil
            }
        }
    }
    
    class Point: NSObject, NSCopying{
        var x:Int
        var y:Int
        
        var direction: Direction?
        var maxX:Int
        var maxY:Int
        var obstacles = Set<Point>()
        var visited = Set<Point>()
        
        init(x: Int, y: Int, direction:Direction? = nil, maxX:Int = 0, maxY:Int = 0) {
            self.x = x
            self.y = y
            self.direction = direction
            self.maxX = maxX
            self.maxY = maxY
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
        
        func directionChange(){
            if direction == .up{
                direction = .right
            }else if direction == .right{
                direction = .down
            }else if direction == .down{
                direction = .left
            }else if direction == .left{
                direction = .up
            }
        }
        
        func move() -> (Bool, Bool){
            let temp = Point(x:self.x, y:self.y)
            if let direction = direction{
                switch direction {
                case .up:
                    temp.x -= 1
                case .down:
                    temp.x += 1
                case .left:
                    temp.y -= 1
                case .right:
                    temp.y += 1
                }
            }
            
            if obstacles.contains(temp){
                return (false, true)
            }
            else if temp.x < 0 || temp.x >= maxX ||
                        temp.y < 0 || temp.y >= maxY{
                return (false, false)
            }
            else{
                self.x = temp.x
                self.y = temp.y
                visited.insert(Point(x: self.x, y: self.y, direction: self.direction))
                return (true, false)
            }
        }
        
        func copy(with zone: NSZone? = nil) -> Any {
            let copy = Point(x: x, y: y, direction: direction, maxX: maxX, maxY: maxY)
            copy.obstacles = obstacles
            return copy
        }
    }
}
