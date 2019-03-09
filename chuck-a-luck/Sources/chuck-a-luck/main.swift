struct Player {
    var name : String
    var credits: Int     
}

let txtEnterPlayer = "Your name:"
let txtEnterGuess = "Your Guess:"
let txtEnterBet = "Your Bet:"
let txtInvalidString = "Not a valid String,  please try again"
let txtInvalidNumber = "Not a valid Number,  please try again"
let txtIntro = "**** Chuck-a-luck ****\nSie haben 1000 Geldeinheiten\nIn jeder Runde können Sie einen Teil davon auf eine der Zahlen 1 bis 6 setzen. Danach werden 3 Würfel geworfen. Falls Ihr Wert dabei ist, erhalten Sie Ihren Einsatz zurück und zusatzlich Ihren Einsatz fuer jeden Würfel,der die von Ihnen gesetzte Zahl zeigt."

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

class Game {
    var player: Player

    init(player: Player) {
        self.player = player        
    }

    func rollDice() -> [Int] {
        var numbers = [Int]()
        for _ in 1...3 {
            numbers.append(Int.random(in: 1 ... 6))
        }        
        return numbers
    }

    func checkOutcome(value: Int, elements: [Int]) -> Int {
        var result = 0
        for element in elements {
            if element == value {
                result += 1
            }
        }
        return result  
    }

    func calcMoney(outcome: Int, bet: Int) -> Int {
        if (outcome == 0) {
            return bet * -1
        } else {
            return bet * outcome
        }
    }

    func gameloop() -> String { 
        var round = 0
        repeat {        
            round += 1
            print("Round \(round) starts !")  
            // Input Player
            let bet = enterInt(message: txtEnterBet)
            if (bet == 0) {
                return "Player leaves game with \(player.credits)"
            } 
            let guess = enterInt(message: txtEnterGuess)
            // Roll Dice
            let numbers = rollDice()
            print("Numbers diced: \(numbers)")  
            // Calc Results
            let outcome = checkOutcome(value: guess, elements: numbers)
            print("Outcome : \(outcome)") 
            let playerMoney = calcMoney(outcome: outcome, bet: bet)
            print("Player wins/looses : \(playerMoney)")
            player.credits += playerMoney
            print("Players credits after Round : \(player.credits)") 
        } while player.credits > 0

        return "Player ran out of money"
    }
}

// Intro
print(txtIntro);

// enter player name
var playerName = enterString(message: txtEnterPlayer)

// create player
let p1 = Player(name: playerName, credits: 100)

// create class
let game = Game(player: p1)
let result = game.gameloop()

// Outro
print(result);

//  func playGame(player: inout Player) -> String { 
//      // lokale Funktion 
//     func rollDice() -> [Int] {
//         var numbers = [Int]()
//         for _ in 1...3 {
//             numbers.append(Int.random(in: 1 ... 6))
//         }        
//         return numbers
//     }

//     func checkOutcome(value: Int, elements: [Int]) -> Int {
//         var result = 0
//         for element in elements {
//             if element == value {
//                 result += 1
//             }
//         }
//         return result  
//     }

//     func calcMoney(outcome: Int, bet: Int) -> Int {
//         if (outcome == 0) {
//             return bet * -1
//         } else {
//             return bet * outcome
//         }
//     }

//     var round = 0
//     repeat {        
//         round += 1
//         print("Round \(round) starts !")  
//         // Input Player
//         let bet = enterInt(message: txtEnterBet)
//         if (bet == 0) {
//             return "Player leaves game with \(player.credits)"
//         } 
//         let guess = enterInt(message: txtEnterGuess)
//         // Roll Dice
//         let numbers = rollDice()
//         print("Numbers diced: \(numbers)")  
//         // Calc Results
//         let outcome = checkOutcome(value: guess, elements: numbers)
//         print("Outcome : \(outcome)") 
//         let playerMoney = calcMoney(outcome: outcome, bet: bet)
//         print("Player wins/looses : \(playerMoney)")
//         player.credits += playerMoney
//         print("Players credits after Round : \(player.credits)") 
//     } while player.credits > 0

//     return "Player ran out of money"
// }