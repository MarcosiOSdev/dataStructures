import UIKit
import Foundation

///Big-O Notion
///
///Do mais performatico para o pior:
///
///1- O(log n), O(1)
///2- O(n)
///3- O(n log n)
///4- O(n²)
///5- O(2ˆn)
///6- O(n!)



/// Constantes O(1).
/// Indepentende do valor passado a resposta sempre sera a mesma

func log(array: [Int]) {
    print(array)
}
print("==== Constantes O(1) ==== ")
log(array: [1, 2, 3])
log(array: [4, 5, 6, 7])

/// Linear O(n).
/// Quantidade de operações realizadas será correspondente ao número de valores informados.

func logOn(array: [Int]) {
    for i in array {
        print(i)
    }
}

print("==== Linear O(n) ==== ")
logOn(array: [1, 2, 3])

/// Exponencial O(n²).
/// Quando se tem uma interação dentro de outra interação.
/// O que torna algoritmos dessa família ineficientes e com baixa performance caso estejamos lidando com um grande número de entrada de dados.

func addAndLog(array: [Int]) {
    var combinationCount = 0
    for i in array {
        for j in array {
            print(i + j)
            combinationCount += 1
        }
    }
    print("combination = \(combinationCount)")
    print("array = \(array)")
}

print("====== Exponencial O(n²) ==== ")
addAndLog(array: [1, 2, 3])



/// Logaritmicos .
/// São os mais performaticos em questão de complexidades.
/// Para exemplo usaremos a busca binaria que é um O(log n).



/// busca binaria, O(log n)
/// função que retorna a posição do chave pesquisada.
///     - Parameters:
///         - array: Array de numero ordernados.
///         - key: Chave que vai pesquisar.
func binarySearch(
    array: [Int],
    key: Int
) -> Int {
    print("== Busca Binaria == ")
    print("== array: \(array), key: \(key) == ")
    var low = 0
    var hight = array.count - 1
    var mid: Int
    var element: Int
    
    while low <= hight {
        mid = Int(floor(Double(low + hight) / 2))
        element = array[mid]
        
        if element < key {
            low = mid + 1
        
        } else if element > key {
            hight = mid - 1
        } else {
            return mid
        }
    }
    return -1
}

let result = binarySearch(array: [1,3,5,7,9], key: 3)
print(result)



/// Bubble Sort , complexidade O(n²)
/// Coloca um Latest para o J não ultrapassar ele ( ser o fim do Array) .
/// se o valor atual é maior que o proximo então realiza a troca,
/// caso o index chega no lastest não percorre mais e diminui o lastest para proxima interação.
func bubbleSort(array: [Int]) -> [Int] {
    var copyArray = array
    
    for i in 0..<copyArray.count - 1 {
        for j in 0..<copyArray.count - i - 1 where copyArray[j] > copyArray[j+1] {
            copyArray.swapAt(j, j + 1)
        }
    }
    return copyArray
}

var array = [5, 1, 0, 15, 10, 9, 8, 11]
print("Original array: \(array)")
print("Bubble sorted: \(bubbleSort(array: array))")
print("=============")


/// Insertion Sort => O(n²)
///

func insertionSort(
    array: [Int],
    by areInIncreasingOrder: ((Int, Int) -> Bool) = (<)
) -> [Int] {
    var data = array
    for i in 1..<data.count {
        let key = data[i]
        var j = i - 1
        // Fica andando as casa até o data[j] ser menor que a key.
        // para atribuir a key no lugar dela abaixo.
        while j >= 0 && areInIncreasingOrder(key, data[j]) {
            data[j+1] = data[j]
            j = j - 1
        }
        
        data[j + 1] = key
    }
    return data
}

print("Original array: \(array)")
print("Insertion sorted: \(insertionSort(array: array))")
print("=============")


///Selection Sort
/// Normal vai percorrendo a lista o menor vai indo para o primeiro.
/// é a mais facil de implementar , porem é a mais lenta.
func selectionSort(
    array: [Int],
    by areInIncreasingOrder: ((Int, Int) -> Bool) = (<)
) -> [Int] {
    
    var data = array
    
    for i in 0..<(data.count-1) {
        var key = i
        
        for j in i+1..<data.count where areInIncreasingOrder(data[j], data[key]) {
            key = j
        }
        
        guard i != key else { continue }
        
        data.swapAt(i, key)
    }
    
    return data
}

print("Original array: \(array)")
print("Selection sorted: \(selectionSort(array: [5, 1, 0, 15, 10, 9, 8]))")
print("=============")


/// Merge Sort, O(nlogn) ou O(n²) em alguns casos.
/// É o famoso dividir para conquistar.
/// Sua ideia é ir divindindo a array top-down
/// Uma das mais rapida , mais rapida que a busca binaria.

func mergeSort(array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }

    let middleIndex = array.count / 2
    
    let leftArray = mergeSort(array: Array(array[0..<middleIndex]))
    let rightArray = mergeSort(array: Array(array[middleIndex..<array.count]))
            
    return merge(leftArray, rightArray)
}

func merge(_ left: [Int], _ right: [Int]) -> [Int] {
    var leftIndex = 0
    var rightIndex = 0
    
    var orderedArray = [Int]()
    
    while leftIndex < left.count && rightIndex < right.count {
        
        let leftElement = left[leftIndex]
        let rightElement = right[rightIndex]
        
        if leftElement < rightElement {
            orderedArray.append(leftElement)
            leftIndex += 1
        
        } else if leftElement > rightElement {
            orderedArray.append(rightElement)
            rightIndex += 1
        
        } else {
            orderedArray.append(leftElement)
            leftIndex += 1
            
            orderedArray.append(rightElement)
            rightIndex += 1
        }
    }
    
    while leftIndex < left.count {
        orderedArray.append(left[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < right.count {
        orderedArray.append(right[rightIndex])
        rightIndex += 1
    }
    
    return orderedArray
}

print("Original array: \(array)")
print("Merge sorted: \(mergeSort(array: array))")
print("=============")


///Quick Sort O(n²)
/// Dos sorts é o menos performatico comparado com o bubble, select e insertion
/// Ele pega o pivot e vai separando os arrays em que os valores menores para esquerda e maiores pra direita do pivot.
/// Até eliminar o da direita ou esquerda.

func quickSort(array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }
    
    var data = array
    let pivot = data.remove(at: 0)
    let left = data.filter { $0 < pivot }
    let right = data.filter { $0 > pivot }
    let middle = [pivot]
    return quickSort(array: left) + middle + quickSort(array: right)
}

print("Original array: \(array)")
print("Quick sorted: \(quickSort(array: array))")
print("=============")


/// Bucket Sort, O(n)
/// Sort linear

func bucketSort(array: [Int]) -> [Int] {
    let data = array
    guard data.count > 0 else { return [] }
    
    let max = data.max()!
    var buckets = [Int](repeating: 0, count: max + 1)
    var out = [Int]()
    
    for i in 0..<data.count {
        buckets[data[i]] = buckets[data[i]] + 1
    }
    
    buckets.enumerated().forEach { index, value in
        guard value > 0 else { return }
        out.append(contentsOf: [Int](repeating: index, count: value))
    }
    
    return out
}
print("Original array: \(array)")
print("Bucket sorted: \(bucketSort(array: array))")
print("=============")
