import Foundation

struct Field {
    let size = 23
    var data = 0
}

let txtIntro = "*** Drei Kreuze ***\nGegeben ist eine Kette von 23 freien Feldern. In jedem Zug setzt jeder der Spieler ein X auf ein freies Feld. Wenn dadurch drei oder mehr X benachbart sind, hat der Spieler gewonnen."
let txtBegin = "Wollen Sie anfangen? (y/n)"
let txtInvalidString = "Not a valid String,  please try again"
let txtInvalidNumber = "Not a valid Number,  please try again"
let txtInvalidCharacter = "Not a valid Character,  please try again"

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

func enterInt(message: String) -> Int {    
    repeat {
       let inputString = enterString(message: message)  
       if let inputInt = Int(inputString) {
            return inputInt
        } else {
            print(txtInvalidNumber)
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

protocol Player {
    var name: String { get } 
    func turn() -> Int
}

class ComputerPlayer: Player {   
    var name = "Comp"
   
    func turn() -> Int {
        return Int.random(in: 1 ... 23)
    }
}

class NormalPlayer: Player {   
    var name = "Player"
    
    func turn() -> Int {
        return enterInt(message: "Please enter field index: ")
    }
}

class Game {    
    let players: [Player]
    var currentPlayerIndex: Int
    var field: Field   

    init(players: [Player], startingPlayerIndex: Int, field: Field) {  
        self.players = players      
        currentPlayerIndex = startingPlayerIndex    
        self.field = field
    }  

    func gameloop() -> String {

        func takeField(index: Int) -> Bool {
            if !fieldUsed(index: index) {
                let tmp = 1 << index;
                field.data = field.data | tmp;
                return true;
            }
            return false;        
        } 

        func fieldUsed(index: Int) -> Bool {
            let tmp = 1 << index
            if (tmp & field.data) == tmp {
                return true
            } else {
                return false
            }
        }  

        func drawField() {
            let symbolUsedUpper = " \\/"
            let symbolUsedLower = " /\\"
            let symbolFree      = "   "         

            func createCrossesRow(symbolUsed: String) -> String {
                var line = ""
                for index in 1...field.size  {
                    if fieldUsed(index: index) {
                        line += symbolUsed
                    } else {
                        line += symbolFree
                    }
                }
                return line
            }

            func createIndexRow() -> String{
                var line = ""
                for index in 1...field.size  {
                    // needs Foundation Lib !
                    let str = String(format: "%3d", index)           
                    line += str
                }
                return line
            }      

            print("")
            print(createCrossesRow(symbolUsed: symbolUsedUpper))
            print(createCrossesRow(symbolUsed: symbolUsedLower))
            print(createIndexRow())
        } 

        func nextPlayer() {
            if (currentPlayerIndex + 1 == players.count) {
                currentPlayerIndex = 0
            } else {
                currentPlayerIndex = currentPlayerIndex + 1
            } 
        }  

        func gameOver() -> Bool {
            var crosses = 0;
            for index in 1...field.size
            {
                if fieldUsed(index: index) {
                    crosses += 1
                    if crosses == 3 {
                        return true
                    }                   
                } else {
                    crosses = 0
                }
            }
            return false
        }       
    
        var indexChoice = 0
        drawField() 
        // repeat until game is over  
        repeat { 
            // repeat until valid indexChoice is chosen
            repeat  {
                indexChoice = players[currentPlayerIndex].turn()
                if indexChoice == 0 {
                    return "Player leaves game"
                }
                print("\(players[currentPlayerIndex].name) takes index \(indexChoice) ")
                if takeField(index: indexChoice) {
                    break;
                }
                print("Sorry, index already taken. Try again")

            } while true

            drawField() 
            if gameOver() {
                return "\(players[currentPlayerIndex].name) wins the game !"
            }
            nextPlayer()
        } while true  
    }
}

print(txtIntro)

// Create Players
let player = NormalPlayer()
let comp = ComputerPlayer()

// put both into array of type player
var players: [Player] = [player, comp]

// Who starts
var startingPlayerIndex: Int?

repeat {
    let choice = enterCharacter(message:txtBegin)
    if (choice == "y") {
        startingPlayerIndex = 0
    } else if (choice == "n") {
        startingPlayerIndex = 1
    } else {
        print(txtInvalidCharacter)
    }
} while startingPlayerIndex == nil

// create field
var field = Field()

// all resources available to start game
let game = Game(players: players, startingPlayerIndex: startingPlayerIndex!, field: field)
let result = game.gameloop()

// showing result
print(result)
