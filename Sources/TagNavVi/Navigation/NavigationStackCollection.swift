//
//  SwiftUIView.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI
import Combine

public class NavigationStackCollection<Tag:Hashable> : ObservableObject {
    @Published var dict:[Tag:NavigationStack<Tag>] = [:]
    var cancellables = [Tag:AnyCancellable]()

    public init(_ dict: [Tag:NavigationStack<Tag>]) {
        self.dict = dict
    }
    
    func append(k:Tag,v:NavigationStack<Tag>) -> NavigationStackCollection<Tag> {
        self.dict[k]=v
        return self
    }

    func observeChildrenChanges() -> NavigationStackCollection<Tag> {
        let dict2 = dict //as! [Tag:NavigationStack<Tag>]
        dict2.forEach({
            let v = $0.value.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() })
            let k : Tag = $0.key
            // Important: You have to keep the returned value allocated,
            // otherwise the sink subscription gets cancelled
            self.cancellables[k]=v
        })
        return self //as! NavigationStackCollection<Tag>
    }
}
