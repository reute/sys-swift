import Foundation

struct Player {
    let name = "Default"
    var mtnList = [String]()
}

let txtInvalidString = "Not a valid String,  please try again"
let txtInvalidNumber = "Not a valid Number,  please try again"
let txtInvalidInput = "Only two parameters allowed"

func enterString(message: String) -> String {    
    print("\(message)", terminator: " ") // Terminate with " " instead of \n
    repeat {
        if let inputString = readLine() {
            return inputString
        } else {
            print(txtInvalidString)
        }
    } while true
}

func enterCharacter(message: String) -> Character { 
    repeat {
       let inputString = enterString(message: message)  
       if inputString.count > 1 {
           print(txtInvalidCharacter)
           continue
       }
       return inputString[inputString.startIndex]       
    } while true
}

func playerInput(message: String) -> (Int, Int) {    
    repeat {
        let inputString = enterString(message: message)  
        let items = inputString.components(separatedBy: " ")
        if items.count != 2 {
            print(txtInvalidInput)
            continue
        }

        if let from = Int(items[0]) {
            if let to = Int(items[1]) {
                return (from, to)
            }               
        } else {
            print(txtInvalidNumber)
        }      
    } while true 
}

func readData(fileName: String, count k: Int) -> [String] {   
    // Read complete file in Array
    var file = ""
    do {
        file = try String(contentsOf: URL(fileURLWithPath: fileName)) 
    } catch {
         print("Error loading file")
    }  
  
    let lines = file.split(separator: "\n") 

    // New Array for the result
    var result = [String]()

    // Place first k elements into result
    for i in 1...k {  
        let line = String(lines[i]) 
        result.append(line)
    }   

    // randomly replace the elements in result with other lines
    for i in k..<lines.count {  
        let j = Int.random(in: 0 ... i)
        if j < k {
            result[j] = String(lines[i])
        }
    }
    return result
}

class Game {
    var player: Player    
    var mtnList: [String] 

    init(player: Player, mtnList: [String]) {
        self.player = player 
        self.mtnList = mtnList
    }

    func printList(title: String, list: [String]) {
        print(title)
        for (index, element) in list.enumerated() {
            print("\(index): \(element)")
        }
        print()
    } 

    func listSorted(list: [String]) -> Bool {
        var maxHeight = 0
        for (_, element) in list.enumerated() {
            let items = element.components(separatedBy: ":")
            if let height = Int(items[1]) {
                if (height > maxHeight) {
                    maxHeight = height
                } else {
                    return false
                }
            }
        }
        return true
    }  

    func runGameLoop() -> String {
        repeat {
            printList(title: "Current state:", list: player.mtnList)
            printList(title: "Still to be sorted:", list: mtnList)
            let (from, to) = playerInput(message: "What is to be inserted where ? ")
            print()
            if (from == 0) {
                return ("Player left game")
            }
            let mtn = mtnList[from]  
            // insert mountain 
            if (to >= player.mtnList.count) {                   
                player.mtnList.append(mtn)
            } else {
                player.mtnList.insert(mtn, at: to)
            } 
            // remove mountain
            mtnList.remove(at: from)          
        } while (listSorted(list: player.mtnList) && mtnList.count > 0)

        printList(title: "Result:", list: player.mtnList)
        if mtnList.count == 0 {
            return "Player won !!"
        } else {
            return "List not sorted anymore"
        }
       
    }
}

let allMtns = readData(fileName: "./berge", count: 8)
let p1 = Player()
let game = Game(player: p1, mtnList: allMtns)
let result = game.runGameLoop()
print(result)


