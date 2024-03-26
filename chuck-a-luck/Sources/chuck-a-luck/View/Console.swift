class Console {
    init() {
         print(txtIntro);
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

    func enterName() -> String {
        return enterString(message: txtEnterPlayer)
    }

    func enterGuess() -> Int {
        return enterInt(message: txtEnterGuess)
    }

    func enterBet() -> Int {
        return enterInt(message: txtEnterBet)
    }

    func newRound(round number: Int) {
        print("Round \(number) starts !")
    }  

    func nextTurn(player name: String) {
        print("\n\(name)'s turn' !")
    }

    func leaveGame(player name: String, with credits: Int) {
        print("\(name) leaves game with \(credits)")
    }

    // func printRoundResults(for players: [String: Player]) {
        
    // }

    func printRoundResults(for numbers: [Int], and players: [String: Player]) {
        print("RESULTS:") 
        print("Numbers diced: \(numbers)")  
        for (name, player) in players {
            print("\(name)'s result:") 
            if player.winnings! > 0 {
                print("Player wins : \(player.winnings!)")
            } else {
                print("Player looses : \(player.winnings!)")
            }          
            print("Players credits after Round : \(player.credits)") 
        }
    }


    // func printCurrentRoundResults() {

    // }
}