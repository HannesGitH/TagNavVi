//
//  SwiftUIView.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI

final class NavigationStack<Tag:Hashable>: ObservableObject,Hashable {
    static func == (lhs: NavigationStack<Tag>, rhs: NavigationStack<Tag>) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: Tag
    var viewStack: [NavigationItem] = []
    var currentView: NavigationItem
    init(tag : Tag,_ currentView: NavigationItem ){
        self.currentView = currentView
        viewStack.append( currentView)
        self.id=tag
    }

    public func unwind(){
        if isHome{ return }
        let previous = viewStack.count - 2
        currentView = viewStack[safe: previous] ?? NavigationItem(EmptyView())
        viewStack.remove(at: previous+1)
        objectWillChange.send()
    }
    public func advance(_ view:NavigationItem){
        currentView = view
        viewStack.append( currentView)
        objectWillChange.send()
    }
    public func advance<UI:View>(_ view:UI){
        currentView = NavigationItem(view)
        viewStack.append(currentView)
        objectWillChange.send()
    }
    public func home( ){
        currentView = viewStack.first ?? NavigationItem(EmptyView())
        viewStack.removeAll()
        viewStack.append(currentView)
        objectWillChange.send()
    }
    public var isHome:Bool {viewStack.count<=1}

    
}
