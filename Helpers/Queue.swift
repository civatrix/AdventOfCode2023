//
//  Queue.swift
//  AdventOfCodeKit
//
//  Created by DanielJohns on 2023-01-24.
//

import Foundation

private final class QueueNode<T> {
    let value: T
    var next: QueueNode<T>?
    
    internal init(value: T) {
        self.value = value
    }
}

struct Queue<Element> {
    private var head: QueueNode<Element>?
    private var tail: QueueNode<Element>?
    
    mutating func append(_ newElement: Element) {
        let oldTail = tail
        tail = QueueNode(value: newElement)
        head = head ?? tail
        oldTail?.next = tail
    }
    
    mutating func dequeue() -> Element? {
        guard let value = head else { return nil }
        head = head?.next
        if head == nil { tail = nil }
        return value.value
    }
    
    func filter(_ isIncluded: @escaping (Element) -> Bool) -> Queue<Element> {
        var new = Queue<Element>()
        for element in self where isIncluded(element) {
            new.append(element)
        }
        
        return new
    }
}

extension Queue: Sequence, IteratorProtocol {
    mutating func next() -> Element? {
        dequeue()
    }
}
