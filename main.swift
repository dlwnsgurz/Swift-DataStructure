var q = CircularQueue<Int>(size: 10)

for i in 0..<10{
    q.enqueue(i)
    print("for-in index: \(i)")
    print("front: \(q.front) || rear: \(q.rear)")
    print("queue size : \(q.size)")
    print("array size : \(q.elements.count)")
    print("")
    print("")
}

print("-------------------------------")
for _ in 0..<10{
    q.dequeue()
}

print("q.peekRear : \(q.peekRear)")
print("q.peekfront : \(q.peekFront)")
print("size : \(q.size)")
print("front :  \(q.front)")
print("rear :  \(q.rear)")
print("")
print("")
print("-------------------------------")

for _ in 0..<8{
    q.enqueue(4)
}

print("q.peekRear : \(q.peekRear)")
print("q.peekfront : \(q.peekFront)")
print("size : \(q.size)")
print("front :  \(q.front)")
print("rear :  \(q.rear)")
