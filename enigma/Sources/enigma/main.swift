import Foundation

let txtInvalidString = "Not a valid String,  please try again"
let txtInvalidNumber = "Not a valid Number,  please try again"

enum Mode {
    case encrypt, decrypt, crack
}

class Enigma {
    let clear   = ("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")
    let key     = ("EKLMF6GDQVZ0TO8Y XUSP2IB4CJ5AR197W3NH")   
    var shift: Int   

    init(shift: Int = 0) {      
        self.shift = shift % key.count       
    }

    func rotate() {
        shift = (shift + 1) % key.count
    }

    func encrypt(plainText: String) -> String {  
        var cipher = [Character]()
        for (index, var char) in plainText.enumerated() { 
            // dont rotate in first round  
            if (index != 0) {
                rotate()
            }
            // change invalid characters to " "
            if !clear.contains(char) {
                char = " "          
            }
            // get index of character in clear   
            if let clearIndex = clear.index(of: char) {
                // String.Index -> Int 
                let indexInt = clear.distance(from: clear.startIndex, to: clearIndex)
                // calculate new Index in Int
                let indexShift = key.count - shift   
                let newIndexInt = (indexShift + indexInt) % key.count
                // Int -> String.Index
                let newIndex = key.index(key.startIndex, offsetBy: newIndexInt)
                cipher.append(key[newIndex])
            }         
        }   
        return String(cipher)
    }

    func decrypt(cipher: String) -> String {
        var plainText = [Character]()
        for (index, var char) in cipher.enumerated() { 
            // dont rotate in first round  
            if (index != 0) {
                rotate()           
            }
            // change invalid characters to " "
            if !key.contains(char) {
                char = " "          
            }
            // get index of character in clear   
            if let keyIndex = key.index(of: char) {
                // String.Index -> Int 
                let indexInt = clear.distance(from: key.startIndex, to: keyIndex)
                // calculate new Index in Int
                let newIndexInt = (indexInt + shift) % key.count 
                // Int -> String.Index
                let newIndex = clear.index(clear.startIndex, offsetBy: newIndexInt)
                plainText.append(clear[newIndex])
            }           
        }    
        return String(plainText)     
    }

    func crack(cipher: String, plainWord: String) -> String? {
        let startIndex = shift
        repeat { 
            let plainText = decrypt(cipher: cipher)
            if plainText.contains(plainWord) {//
                return plainText
            }  
            rotate()       
        } while startIndex != shift
        return nil
    }
}

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

func enterWalzenstellung() -> Int {
    repeat {
        let tmp = enterInt(message: "Bitte Walzenstellung eingeben: ")
        if (tmp < 0) {
            print("Bitte wiederholen")
        } else {
            return tmp            
        }    
    } while true
}

func enterMode() -> Mode {
     repeat {
        let mode = enterInt(message: "1 - Verschlüsseln\n2 - Entschlüsseln\n3 - Crack\n ")
        switch mode {
            case 1: return Mode.encrypt
            case 2: return Mode.decrypt
            case 3: return Mode.crack
            default: print("Bitte wiederholen") 
        }       
    } while true
}

print(" * * * * ENIGMA * * * * *")

let text = enterString(message: "Bitte Text eingeben: ").uppercased()
let mode = enterMode()

var walzenStellung = 0
if (mode != .crack) {
    walzenStellung = enterWalzenstellung()
}

let enigma = Enigma(shift: walzenStellung)

switch mode {
    case .encrypt: 
        print(enigma.encrypt(plainText: text))
    case .decrypt:
        print(enigma.decrypt(cipher: text))
    case .crack:
        let plainWord = enterString(message: "Suchwort eingeben: ").uppercased()
        if let plainText = enigma.crack(cipher: text, plainWord: plainWord) {
            print("Lösung gefunden !\nEntschlüsselter Text: \n \(plainText)") 
        } else {
            print("Keine Lösung")
        }
}