import Foundation

public struct Day9 {
    
    public static func part1() -> Int{
        let text = Bundle.main.getInput(file: "input_day9")?.trimmingCharacters(in: .whitespaces)
        let line = text!.split(separator: "\n").map{ String($0) }.first!
        var diskMap = Array(line)
        var sum = 0
        
        var frontIndex = 0
        var backIndex = diskMap.count % 2 == 0 ? diskMap.count-2 : diskMap.count-1
        
        for i in 0..<diskMap.count{
            if i % 2 != 0{
                
                // free space
                var space = Int("\(diskMap[i])") ?? 0
                
                if space > 0 {
                    repeat{
                        var value = Int("\(diskMap[backIndex])") ?? 0
                        
                        if value > 0 {
                            sum += frontIndex * Int(backIndex/2)
                            
                            value -= 1
                            diskMap[backIndex] = Array("\(value)").first!
                            space -= 1
                            diskMap[i] = Array("\(space)").first!
                            
                            frontIndex += 1
                        }else{
                            if backIndex > 2 {
                                backIndex -= 2
                            }else{
                                break
                            }
                            
                            if i > backIndex {
                                continue
                            }
                        }
                    }while space > 0
                }
            }else{
                // data
                let value = Int("\(diskMap[i])") ?? 0
                diskMap[i] = "0"
                for _ in 0..<value{
                    sum += frontIndex * Int(i/2)
                    frontIndex += 1
                }
            }
        }
        return sum
    }
    
    public static func part2() -> Int{
        let text = Bundle.main.getInput(file: "input_day9")?.trimmingCharacters(in: .whitespaces)
        let line = text!.split(separator: "\n").map{ String($0) }.first!
        var diskMap = Array(line)
        let diskMapDup = Array(line)
        
        var sum = 0
        
        var frontIndex = 0
        let back = diskMap.count % 2 == 0 ? diskMap.count-2 : diskMap.count-1
        var backIndex = back
        
        for i in 0..<diskMap.count{
            if i % 2 != 0{
                
                // free space
                var space = Int("\(diskMap[i])") ?? 0
                backIndex = back
  
                if space > 0 {
                    repeat{
                        
                        space = Int("\(diskMap[i])") ?? 0
                        
                        let value = Int("\(diskMap[backIndex])") ?? 0
                        
                        if value > 0 {
                            if value <= space{
                                
                                diskMap[backIndex] = "0"
                                space = space - value
                                diskMap[i] = Array("\(space)").first!
                                
                                for _ in 0..<value{
                                    sum += frontIndex * Int(backIndex/2)
                                    frontIndex += 1
                                }
                                
                                if backIndex > 2 {
                                    backIndex -= 2
                                }else{
                                    break
                                }
                                
                            }else{
                                if backIndex > 2 {
                                    backIndex -= 2
                                }else{
                                    break
                                }
                            }
                        }else{
                            if backIndex > 2 {
                                backIndex -= 2
                            }else{
                                break
                            }
                            
                            if i > backIndex {
                                continue
                            }
                        }
                    }while space > 0
                }
                
                if space > 0 {
                    frontIndex += space
                }
            }else{
                // data
                let value = Int("\(diskMap[i])") ?? 0
                
                diskMap[i] = "0"
                if value > 0{
                    for _ in 0..<value{
                        sum += frontIndex * Int(i/2)
                        frontIndex += 1
                    }
                    
                }else{
                    let valueOrig = Int("\(diskMapDup[i])") ?? 0
                    frontIndex += valueOrig
                }
            }
        }
        return sum
    }
}
