import Foundation


func staircase(n: Int) -> Void {
    // Write your code here
    for i in 1...n {
        let spaces = n - i
        let tags = i
        let spacesText = String(repeating: " ", count: spaces)
        let tagsText = String(repeating: "#", count: tags)
        print("\(spacesText)\(tagsText)")
    }
}

func miniMaxSum(arr: [Int]) -> Void {
    // Write your code here
    let sortedArray = arr.sorted()
    var reversedArray = arr.sorted()
    
    reversedArray.reverse()
    
    var minSum = 0
    var maxSum = 0
    
    for i in 1..<sortedArray.count {
        maxSum += sortedArray[i]
        minSum += reversedArray[i]
    }
    
    print("\(minSum) \(maxSum)")

}

miniMaxSum(arr: [1,4,5,2,3])

//staircase(n: 4)
