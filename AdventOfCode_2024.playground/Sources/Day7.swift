import Foundation

public struct Day7 {
    
    struct Node: Hashable {
        let value: Int
        var neighbors: [Node]
        var numbers: [Int]
        var calculated: Int = 0
    }
    
    public static func part1() -> Int {
        let text = Bundle.main.getInput(file: "input_day7")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n").map{ String($0) }
        
        var sum = 0
        for line in lines{
            let comp = line.components(separatedBy: ":").map{ String($0) }
            let value = Int(comp[0])!
            let numbers = Array(comp[1].components(separatedBy: " ")).reversed().compactMap{ Int($0) }
            let root = Node(value: value, neighbors: [], numbers: numbers)
            if correctEquation(root: root){
                sum += value
            }
        }
        
        return sum
    }
    
    public static func part2() -> Int {
        let text = Bundle.main.getInput(file: "input_day7")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n").map{ String($0) }
        
        var sum = 0
        for line in lines{
            let comp = line.components(separatedBy: ":").map{ String($0) }
            let value = Int(comp[0])!
            var numbers = Array(comp[1].components(separatedBy: " ")).compactMap{ Int($0) }
            let first = numbers.removeFirst()
            let root = Node(value: value, neighbors: [], numbers: numbers, calculated: first)
            if correctConcatenationEquation(root: root){
                sum += value
            }
        }
        
        return sum
    }
    
    static func correctEquation(root: Node) -> Bool {
        var visited = Set<Node>()
        var stack = [Node]()

        stack.append(root)

        while !stack.isEmpty {
            var current = stack.popLast()!
        
            guard let nextNum = current.numbers.first else {
                return false
            }

            var numbers = current.numbers
            numbers.removeFirst()
            
            if (current.value - nextNum) == 0 {
                return true
            }else if numbers.count > 0 {
                let node = Node(value: current.value - nextNum,
                                neighbors: [],
                                numbers: numbers
                )
                current.neighbors.append(node)
            }
            
            if (current.value % nextNum) == 0 {
                if (current.value / nextNum) == 0{
                    return true
                }else if numbers.count > 0 {
                    let node = Node(value: current.value / nextNum,
                                    neighbors: [],
                                    numbers: numbers
                    )
                    current.neighbors.append(node)
                }
            }
        
            visited.insert(current)
        
            for neighbor in current.neighbors {
                if !visited.contains(neighbor) {
                    stack.append(neighbor)
                }
            }
        }
      
        return false
    }
    
    static func correctConcatenationEquation(root: Node) -> Bool {
        var visited = Set<Node>()
        var stack = [Node]()

        stack.append(root)

        while !stack.isEmpty {
            var current = stack.popLast()!
        
            guard let nextNum = current.numbers.first else {
                return false
            }

            var numbers = current.numbers
            numbers.removeFirst()
            
            if (current.calculated + nextNum) == current.value && numbers.count == 0{
                return true
            }else if numbers.count > 0 {
                let node = Node(value: current.value,
                                neighbors: [],
                                numbers: numbers,
                                calculated: current.calculated + nextNum
                )
                current.neighbors.append(node)
            }
            
            if (current.calculated * nextNum) == current.value && numbers.count == 0{
                return true
            }else if numbers.count > 0 {
                let node = Node(value: current.value,
                                neighbors: [],
                                numbers: numbers,
                                calculated: current.calculated * nextNum
                )
                current.neighbors.append(node)
            }
            
            if "\(current.calculated)\(nextNum)" == "\(current.value)" && numbers.count == 0{
                return true
            }else if numbers.count > 0 {
                if let val = Int("\(current.calculated)\(nextNum)") {
                    let node = Node(value: current.value,
                                    neighbors: [],
                                    numbers: numbers,
                                    calculated: val
                    )
                    current.neighbors.append(node)
                }
            }
        
            visited.insert(current)
        
            for neighbor in current.neighbors {
                if !visited.contains(neighbor) {
                    stack.append(neighbor)
                }
            }
        }
      
        return false
    }
}
