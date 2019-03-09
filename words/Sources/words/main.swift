import Foundation

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

let fileName = "cities.txt"
let cities = readData(fileName: fileName)

print(cities)


