import Foundation

public struct Day6 {
    
    public static func part1() -> Int{
        let text = Bundle.main.getInput(file: "input_day6")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n").map{ Array($0) }
        
        var guardLoc:PointExtended?
        var obstacles = Set<PointExtended>()
        
        for (x, line) in lines.enumerated(){
            for (y, char) in line.enumerated(){
                if char == "^"{
                    guardLoc = PointExtended(x: x, y: y, direction: .up, maxX: lines.count, maxY: line.count)
                }
                else if char == "#"{
                    obstacles.insert(PointExtended(x: x, y: y))
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
        
        return guardLoc?.visited.count ?? 0
    }
    
    public static func part2() -> Int{
        let text = Bundle.main.getInput(file: "input_day6")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n").map{ Array($0) }
        
        var guardLoc:PointExtended?
        var obstacles = Set<PointExtended>()
        
        for (x, line) in lines.enumerated(){
            for (y, char) in line.enumerated(){
                if char == "^"{
                    guardLoc = PointExtended(x: x, y: y, direction: .up, maxX: lines.count, maxY: line.count)
                }
                else if char == "#"{
                    obstacles.insert(PointExtended(x: x, y: y))
                }
            }
            guardLoc?.obstacles = obstacles
        }
        
        var loops = 0
        
        if let guardLoc = guardLoc {
            for (x, line) in lines.enumerated(){
                for (y, _) in line.enumerated(){
                    let point = PointExtended(x: x, y: y)
                    
                    if !obstacles.contains(point) && !(point.x == guardLoc.x && point.y == guardLoc.y){
                        if obstacles.map({ $0.x == x }).count > 0 || obstacles.map({ $0.y == y }).count > 0 {
                            
                            let guardC = guardLoc.copy() as! PointExtended
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
                                    
                                    point.visited.insert(PointExtended(x: guardC.x, y: guardC.y, direction: guardC.direction))
                                    guardC.directionChange()
                                    moved = true
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return loops
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
    
    class PointExtended: Point{
        
        var direction: Direction?
        var maxX:Int
        var maxY:Int
        var obstacles = Set<PointExtended>()
        var visited = Set<PointExtended>()
        
        init(x: Int, y: Int, direction:Direction? = nil, maxX:Int = 0, maxY:Int = 0) {
            self.direction = direction
            self.maxX = maxX
            self.maxY = maxY
            super.init(x: x, y: y)
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
            let temp = PointExtended(x:self.x, y:self.y)
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
                visited.insert(PointExtended(x: self.x, y: self.y, direction: self.direction))
                return (true, false)
            }
        }
        
        override func copy(with zone: NSZone? = nil) -> Any {
            let copy = PointExtended(x: x, y: y, direction: direction, maxX: maxX, maxY: maxY)
            copy.obstacles = obstacles
            return copy
        }
    }
}
