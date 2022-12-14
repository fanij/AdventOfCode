import Foundation

public struct Day7 {
    
    class File {
        var name: String
        var size: Int
        
        init(_ name: String, size: Int) {
            self.name = name
            self.size = size
        }
    }
    
    class Node<T>{
        var value: T
        var children: [Node]
        weak var parent: Node?
        var files: [File]
        
        init(_ value: T) {
            self.value = value
            children = []
            files = []
        }

        init(_ value: T, children: [Node] = [], files: [File] = []) {
            self.value = value
            self.children = children
            self.files = files

            for child in self.children {
                child.parent = self
            }
        }
        
        func add(child: Node) {
            child.parent = self
            children.append(child)
        }
        
        func findChild(_ val: String) -> Node<T>?{
            if children.isEmpty { return nil }
            for child in children {
                if "\(child.value)" == val {
                    return child
                }
            }
            return nil
        }
        
        func addFile(_ file: File) {
            files.append(file)
        }
        
        func dirSize() -> Int{
            return files.map{$0.size}.reduce(0, +) + children.map{$0.dirSize()}.reduce(0, +)
        }
        
        func dirSize(below: Int) -> Int{
            let size = files.map{$0.size}.reduce(0, +) + children.map{$0.dirSize()}.reduce(0, +)
            return size < below ? size : 0
        }
        
        func sum(below: Int) -> Int{
            return self.dirSize(below: below) + children.map{ $0.sum(below: below)}.reduce(0, +)
        }
        
        func allDirSizes(all: inout [Int]){
            all.append(dirSize())
            for child in children {
                child.allDirSizes(all: &all)
            }
        }
    }
    
    static func makeTree(text: String) -> Node<String>{
        let mainNode = Node("/")
        var currentNode = mainNode
        
        var commands  = text.split(separator: "$ ")
        commands.removeFirst()
        for command in commands {
            
            if command.hasPrefix("cd"){
                var com = String(command)
                com = com.replacingOccurrences(of: "\n", with: "")
                if let dir = com.split(separator: " ").last{
                    if dir == ".."{
                        if let parent = currentNode.parent{
                            currentNode = parent
                        }
                    }else{
                        if let exists = currentNode.findChild(String(dir)){
                            currentNode = exists
                        }else{
                            let node = Node<String>(String(dir))
                            currentNode.add(child: node)
                            currentNode = node
                        }
                    }
                }
            }
            else if command.description.hasPrefix("ls"){
                var lines = command.split(separator: "\n")
                lines.removeFirst()
                for line in lines {
                    let parts = line.split(separator: " ")
                    if line.hasPrefix("dir"){
                        if currentNode.findChild(String(parts[1])) == nil{
                            let node = Node<String>(String(parts[1]))
                            currentNode.add(child: node)
                        }
                    }else{
                        let file = File(String(parts[1]), size: Int(parts[0]) ?? 0)
                        currentNode.addFile(file)
                    }
                }
            }
        }
        
        return mainNode
    }
    
    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day7") ?? ""
        let mainNode = makeTree(text: text)

        print("\(mainNode.sum(below: 100000))")
    }
    
    public static func part2() {
        let text = Bundle.main.getInput(file: "input_day7") ?? ""
        let mainNode = makeTree(text: text)
        let used = mainNode.dirSize()
        let delete = 30000000 - (70000000 - used)
        
        var allSizes = [Int]()
        mainNode.allDirSizes(all: &allSizes)
        let smallest = allSizes.compactMap{ $0 > delete ? $0 : nil }.sorted().first ?? 0
        print("\(smallest)")
    }
}
