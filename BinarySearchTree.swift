class BinarySearchTreeByLinkedList<Element: Comparable>{
    
    private(set) var count = 0
    
    var root: Node<Element>?
    
    func insert(_ data: Element){
        guard let root = self.root else {
            self.root = Node(data: data)
            return
        }
        var currentNode = root
        while true{
            if data > currentNode.data{
                guard let right = currentNode.right else {
                    currentNode.right = Node(data: data)
                    count += 1
                    return
                }
                currentNode = right
            }else if data < currentNode.data{
                guard let left = currentNode.left else {
                    currentNode.left = Node(data: data)
                    count += 1
                    return
                }
                currentNode = left
            }
        }
    }
    
    func search(for data: Element) -> Bool{
        guard let root = self.root else {
            return false
        }
        
        var currentNode = root
        while true{
            if data > currentNode.data {
                guard let right = currentNode.right else {
                    return false
                }
                currentNode = right
            }else if data < currentNode.data{
                guard let left = currentNode.left else {
                    return false
                }
                currentNode = left
            }else{
                return true
            }
        }
    }
    
    func remove(data: Element) -> Element?{
        if !search(for: data) { return nil }
        guard let root = self.root else { return nil }
        
        var removeNode = root
        var parentNode = removeNode
        while(true){
            if data > removeNode.data {
                parentNode = removeNode
                removeNode = removeNode.right!
            }else if data < removeNode.data{
                parentNode = removeNode
                removeNode = removeNode.left!
            }else{
                break
            }
        }
        /// 지울 노드가 부모 노드의 왼쪽인지 오른쪽인지 구분 해야함..
        if let left = removeNode.left, let _ = removeNode.right{
            var leafNode = left
            var leafParentNode = leafNode
            while leafNode.right != nil {
                leafParentNode = leafNode
                leafNode = leafNode.right!
            }
            leafNode.left = removeNode.left
            leafNode.right = removeNode.right
            parentNode.right = leafNode
            leafParentNode.right = nil
        }
        
        if let left = removeNode.left{
            
        }
        
        if let right = removeNode.right{
            
        }

        
    }

    
}


class Node<Element: Comparable>{
    
    var data: Element
    var left: Node<Element>?
    var right: Node<Element>?
    
    init(data: Element){
        self.data = data
    }
}

extension BinarySearchTreeByLinkedList{
    func drawDiagram() {
        print(diagram(for: self.root))
    }
     
    private func diagram(for node: Node<Element>?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
       guard let node = node else {
            return root + "nil\n"
        }
        if node.left == nil && node.right == nil {
            return root + "\(node.data)\n"
        }
        return diagram(for: node.right, top + " ", top + "┌──", top + "│ ")
            + root + "\(node.data)\n"
            + diagram(for: node.left, bottom + "│ ", bottom + "└──", bottom + " ")
    }
}
