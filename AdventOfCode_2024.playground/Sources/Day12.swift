import Foundation

public struct Day12 {
    
    public static func part1() -> Int{
        let text = Bundle.main.getInput(file: "input_day12")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n")
            .map{ String($0).split(separator: "").map{ Character( String($0))} }
        
        var dictPassed = [Character: Set<PointExtended>]()
        var regions = [PointExtended]()
        
        for line in lines.enumerated() {
            for char in lines[line.offset].enumerated() {
                
                let point = PointExtended(x: line.offset, y: char.offset, character: char.element)
                if !(dictPassed[char.element]?.contains(point) ?? false){
                    
                    var stack = Set<PointExtended>()
                    stack.insert(point)
                    
                    while(!stack.isEmpty){
                        let current = stack.removeFirst()
                        dictPassed[current.character, default: []].insert(current)
                        point.area += 1
                        
                        let all = current.neighbors(grid: lines).filter{ $0.character == current.character }
                        point.perimeter += 4 - all.count
                        
                        for a in all{
                            if !(dictPassed[a.character]?.contains(a) ?? false){
                                stack.insert(a)
                            }
                        }
                    }
                    regions.append(point)
                }
            }
        }
        return regions.map{ $0.area * $0.perimeter }.reduce(0, +)
    }
    
    public static func part2() -> Int{
        let text = Bundle.main.getInput(file: "input_day12")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n")
            .map{ String($0).split(separator: "").map{ Character( String($0))} }
        
        var dictPassed = [Character: Set<PointExtended>]()
        var regions = [PointExtended]()
        
        for line in lines.enumerated() {
            for char in lines[line.offset].enumerated() {
                
                let point = PointExtended(x: line.offset, y: char.offset, character: char.element)
                if !(dictPassed[char.element]?.contains(point) ?? false){
                    
                    var stack = Set<PointExtended>()
                    stack.insert(point)
                    
                    while(!stack.isEmpty) {
                        
                        let current = stack.removeFirst()
                        dictPassed[current.character, default: []].insert(current)
                        point.area += 1
                        
                        let neighbors = current.neighbors(grid: lines)
                        let all = neighbors.filter{ $0.character == current.character }
                        
                        point.perimeter += 4 - all.count
                        
                        let corners = current.corners(grid: lines)
                        for corner in corners {
                            point.corners.insert(corner)
                        }
                        
                        for a in all {
                            if !(dictPassed[a.character]?.contains(a) ?? false) {
                                stack.insert(a)
                            }
                        }
                    }
                    regions.append(point)
                }
            }
        }
        
        let price = regions.map{ $0.area * $0.corners.count }.reduce(0, +)
        return price
    }
}

extension Day12 {
    
    class PointExtended: Point {
        var character: Character
        var perimeter = 0
        var corners = Set<String>()
        var area = 0
        
        init(x: Int, y: Int, character:Character) {
            self.character = character
            super.init(x: x, y: y)
        }
        
        func neighbors(grid: [[Character]]) -> [PointExtended] {
            var list = [PointExtended]()
            if let up = grid[safe: x-1]?[safe: y]{
                list.append(PointExtended(x: x-1, y: y, character: up))
            }
            if let down = grid[safe: x+1]?[safe: y]{
                list.append(PointExtended(x: x+1, y: y, character: down))
            }
            if let before = grid[safe: x]?[safe: y-1]{
                list.append(PointExtended(x: x, y: y-1, character: before))
            }
            if let after = grid[safe: x]?[safe: y+1]{
                list.append(PointExtended(x: x, y: y+1, character: after))
            }
            return list
        }
        
        func corners(grid: [[Character]]) -> [String] {
            var list = [String]()
            
            let up = grid[safe: x-1]?[safe: y] ?? "*"
            let down = grid[safe: x+1]?[safe: y] ?? "*"
            let before = grid[safe: x]?[safe: y-1] ?? "*"
            let after = grid[safe: x]?[safe: y+1] ?? "*"
            
            let upLeft = grid[safe: x-1]?[safe: y-1] ?? "*"
            let upRight = grid[safe: x-1]?[safe: y+1] ?? "*"
            
            let downLeft = grid[safe: x+1]?[safe: y-1] ?? "*"
            let downRight = grid[safe: x+1]?[safe: y+1] ?? "*"
            
            if(up != character && before != character){
                list.append("upLeft_x:\(x)_y:\(y)")
            }
            else if(up == character && before == character && upLeft != character){
                list.append("upLeft_x:\(x)_y:\(y)")
            }
        
            if(up != character && after != character){
                list.append("upRight_x:\(x)_y:\(y)")
            }
            else if(up == character && after == character && upRight != character){
                list.append("upRight_x:\(x)_y:\(y)")
            }
        
            if(down != character && before != character){
                list.append("downLeft_x:\(x)_y:\(y)")
            }
            else if(down == character && before == character && downLeft != character){
                list.append("downLeft_x:\(x)_y:\(y)")
            }
        
            if(down != character && after != character){
                list.append("downRight_x:\(x)_y:\(y)")
            }
            else if(down == character && after == character && downRight != character){
                list.append("downRight_x:\(x)_y:\(y)")
            }
            
            return list
        }
        
        override var description: String {
            return "(\(x),\(y)) p:\(character) a:\(area) r:\(corners)"
        }
    }
}
