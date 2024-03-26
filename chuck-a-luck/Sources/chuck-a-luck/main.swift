

func enterPlayerNames() -> [String] {
    var names = [String]()
    while true {      
        let name = view.enterName()       
        if name.isEmpty {
            if names.isEmpty {
                continue
            } else {
                break
            } 
        }
        names.append(name)
    }   
    return names
}

// CREATE VIEW
let view = Console()

// get initial values for setting up Model
let playerNames = enterPlayerNames()

// CREATE MODEL
let model = Game(playerNames: playerNames)

func gameloop() -> String {     
    repeat {
        view.newRound(round: model.round)
        
        for playerName in model.getPlayerNames() {           
            view.nextTurn(player: playerName)
            // Input Player
            let bet = view.enterBet() 
            if (bet == 0) {
                view.leaveGame(player: playerName, with: model.getCredits(from: playerName)!)
                model.remove(player: playerName)
                continue             
            } 
            model.setBet(for: playerName, to: bet)
            let guess = view.enterGuess()
            model.setGuess(for: playerName, to: guess)
        }        
        // calculateRound
        let roundResults = model.calculateRound()
        view.printRoundResults(for: roundResults.numbers, and: roundResults.players)
        if 
        
    } while true //player.credits > 0

    return "Player ran out of money"
}

// ACT ON MODEL
let result = gameloop()

// // Outro
print(result)


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