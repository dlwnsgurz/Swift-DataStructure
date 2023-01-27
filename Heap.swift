class MaxHeap<Element: Comparable>{
    
    var elements = [Element]()
    
    /// 힙의 크기를 return
    var size: Int{
        return elements.count - 1
    }
    
    /// 힙이 비어있는 경우 return true.
    var isEmpty: Bool{
        return size == 0
    }
    
    /// 힙 내의 맨 마지막 인덱스를 return
    var leafIndex: Int{
        return size
    }
    
    var max: Element?{
        if isEmpty { return nil }
        return elements[1]
    }
    
    // 편의를 위해 인덱스 0을 채워둔다.
    init(data: Element){
        elements.append(data)
        elements.append(data)
    }
    
    func map(formular: (Element) -> (Element)) -> [Element]{
        var array = [Element]()
        for index in 1...size{
            array.append(formular(elements[index]))
        }
        return array
    }
    
    /// 힙을 [Element]로 return
    func toArray() -> [Element]{
        return map{ $0 }
    }
    
    /// 최대 힙에 원소를 삽입합니다.
    func insert(_ data: Element){
        
        elements.append(data)
        var currentIndex = elements.count - 1
        var parentIndex = currentIndex / 2
        
        while parentIndex > 0 {
            if data > elements[parentIndex]{
                elements.swapAt(parentIndex, currentIndex)
                currentIndex /= 2
                parentIndex /= 2
                continue
            }else{ break }
        }
    }
    
    /// 최대 힙에 원소를 삭제하고 옵셔널로 반환합니다.
    /// 힙 내에 원소가 없는 경우 nil을 반환합니다.
    @discardableResult
    func pop() -> Element?{
        if isEmpty { return nil }
        
        // 루트 노드삭제 후, 맨 마지막 노드를 루트노드로.
        let popData = elements[1]
        elements[1] = elements[leafIndex]
        elements.removeLast()
        
        // 루트 노드 인덱스
        var index = 1
        
        while true{
            
            let leftIndex = index * 2
            let rightIndex = index * 2 + 1
            
            // 자식 노드 모두 있는 경우
            if leftIndex <= size && rightIndex <= size{
                
                let maxDataIndex = elements[leftIndex] > elements[rightIndex] ? leftIndex : rightIndex
                if elements[index] < elements[maxDataIndex] {
                    elements.swapAt(maxDataIndex, index)
                    index = maxDataIndex
                    continue
                }
                return popData
            }
            
            // 왼쪽 자식 노드만 있는 경우
            if leftIndex == size {
                
                if elements[leftIndex] > elements[index]{
                    elements.swapAt(leftIndex, index)
                    index = leftIndex
                }
                return popData
            }
            
            // 자식 노드가 없는 경우
            if leftIndex > size && rightIndex > size { return popData }
        }
    }
    
    
    func printHeap(){
        
        for i in 1..<elements.count{
            print("\(elements[i])", terminator: " ")
        }
        print("")
    }
}
