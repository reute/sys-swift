struct Player {
    var credits: Int  
    var bet: Int?
    var guess: Int?
    var winnings: Int?
}

class Game {
    let guessMin = 0
    let guessMax = 6

    var roundNumber = 1
    var numbersDice = [Int]() 

    private var players = [String: Player]() 
    private var rounds = [[String: Player]]()
    private(set) var round = 0

    init(playerNames: [String]) {
        for name in playerNames {  
            let player = Player(credits: 100, bet: nil, guess: nil, winnings: nil)   
            players[name] = player
        } 
        print(players)     
    }

    // Get stuff
    func getPlayerNames() -> [String] {
        return Array(players.keys)
    }

    func getCredits(from name: String) -> Int? {
        return players[name]?.credits        
    }

    // func getCredits(from name: String, for round: Int) -> Int {
    //     return rounds[round]![name]!.credits
    // }

    // func getWinnings(from name: String) -> Int {
    //      return players[name]!.winnings        
    // }

    // func getWinnings(from name: String, for round: Int) -> Int {
    //      return rounds[round]![name]!.winnings     
    // }   

    // Set stuff

    func setBet(for name: String, to bet: Int) {
        players[name]?.bet = bet 
    }

    func setGuess(for name: String, to guess: Int) {
        players[name]?.guess = guess
    }

    func remove(player name: String) {
        players[name] = nil
    }

    // Do stuff
    func calculateRound() -> (numbers: [Int], players: [String: Player]) {         
        round += 1
        // Roll Dice
        let numbersDice = rollDice()
        // Calc Results for each player
        for (name, player) in players {
            let winnings = calcOutcome(for: player.guess!, with: player.bet!, with: numbersDice)            
            players[name]!.winnings = winnings 
            players[name]!.credits += winnings
        }
        rounds.append(players)
        return (numbersDice, players)
    }
   
    func calcOutcome(for guess: Int, with bet: Int, with numbersDice: [Int]) -> Int {      
        var outcome = 0
        for number in numbersDice {
            if number == guess {
                outcome += 1
            }
        }
        if (outcome == 0) {
            return bet * -1
        } else {
            return bet * outcome
        }       
    }

    func rollDice() -> [Int] {
        var numbers = [Int]()
        for _ in 1...3 {
            numbers.append(Int.random(in: 1 ... 6))
        }        
        return numbers
    }

    // func setBet(amount: Int, for player: String) {

    // }

    // func getBetLimit(for name: String) -> Int {
    //     return 100
    // }

    // func getGuessLimits() -> (min: Int, max: Int) {
    //     return (min: guessMin, max: guessMax)
    // }


   
}