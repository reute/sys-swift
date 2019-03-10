import Foundation

let txtInvalidString = "Not a valid String,  please try again"

enum AddResult {
    case notFound, notAdded, added
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

func readData(fileName: String) -> [String] {   
    // Read complete file in Array 
    do {
        let url = URL(fileURLWithPath: fileName)
        let file = try String(contentsOf: url)  
        return file.components(separatedBy: "\n")         
    } catch {
         print("Error loading file \(fileName)")
         exit(0)
    } 
}

// Class which handles all operations on chain
class ChainHandler {
    var cities: [String]
    var chain = [String]()

    init(cities: [String]) {
        self.cities = cities
    }

    enum FittingResult {
        case fitsBegin, fitsEnd, notFitting
    }

    func getFittingCities() -> [String] {
        if (chain.isEmpty) {
            return cities
        }

        var fittingCities = [String]()
        // loop all cities and check if they fit
        for index in 0..<cities.count {           
            let fitResult =  isCityFitting(cityIndex: index)  
            if fitResult == .fitsBegin || fitResult == .fitsEnd {               
                fittingCities.append(cities[index])
            }          
        }
        return fittingCities
    }   

    func addCity(city: String) -> AddResult {
        func getCityIndex() -> Int? {
            for (index, element) in cities.enumerated() {
                if element.uppercased() == city.uppercased() {
                    return index
                }
            }
            return nil
        } 
        
        let tmp = getCityIndex()
        if tmp == nil {
            return .notFound
        }

        let cityIndex = tmp!
        let fittingResult = isCityFitting(cityIndex: cityIndex)
        switch fittingResult {
            case .fitsBegin:  
                chain.insert(cities[cityIndex], at: 0) 
            case .fitsEnd:
                chain.append(cities[cityIndex]) 
            case .notFitting:
                return .notAdded           
        }
        cities.remove(at: cityIndex)       
        return .added        
    }

     // INTERNAL FUNCITON
    func isCityFitting(cityIndex: Int) -> FittingResult {
        if chain.isEmpty {            
            return .fitsEnd
        }
        // fit begin
        // last char city
        let addCity = cities[cityIndex].uppercased()
        let lastChar = addCity[addCity.index(before: addCity.endIndex)]    
        // first char in chain
        var chainCity = chain[chain.startIndex].uppercased()
        let chainFirstChar = chainCity[chainCity.startIndex] 
        
        if (lastChar == chainFirstChar) {           
            return .fitsBegin
        }
        // fit end
        // first char city        
        let firstChar = addCity[addCity.startIndex] 
        // last char in chain
        chainCity = chain[chain.index(before: chain.endIndex)].uppercased()
        let chainLastChar = chainCity[chainCity.index(before: chainCity.endIndex)] 
        
        if (firstChar == chainLastChar) {         
            return .fitsEnd
        }
        return .notFitting
    } 
}

let fileName = "cities.txt"
let cities = readData(fileName: fileName)
let ch = ChainHandler(cities: cities)
var fittingCities = cities

repeat {
    //print("Current chain: \(ch.chain[chain.startIndex]) ... \(ch.chain[chain.index(before: chain.endIndex)])")   
    print("\n\(ch.chain)")
    print("\(ch.cities.count) words left")
    let city = enterString(message: "Next City: ")
    if (city.isEmpty) {          
        print(fittingCities)   
    } else if city == "q" {       
        print("Player quits")
        break
    } else {
        let result = ch.addCity(city: city)
        switch result {
            case .notFound: 
                print("Word not found in list")
                break
            case .notAdded: 
                print("Word doesn't fit")
                break
            case .added: 
                print("Word added") 
        }
    } 
    // Check if there are fitting cities left
    fittingCities = ch.getFittingCities()
    if  fittingCities.isEmpty {
        print("No more words available, you won") 
        break
    }   
} while true
