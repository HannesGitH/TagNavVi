//
//  SwiftUIView.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI

public struct TagNavigationLink< Tag : Hashable, Label:View, Destination:View> : View {
    
    @EnvironmentObject var navs: NavigationStackCollection<Tag>
    
    private var to : Destination
    private var tag : Tag
    private var label : ()->Label
    private var isActive : Binding<Bool>
    
    /// Creates an instance that presents `destination`.
    public init(parentTag : Tag , destination: Destination, @ViewBuilder label: @escaping () -> Label){
        self.to = destination
        self.tag = parentTag
        self.label = label
        self.isActive = .constant(false)
    }

    /// Creates an instance that presents `destination` when active.
    public init(parentTag : Tag , destination: Destination, isActive: Binding<Bool>, @ViewBuilder label: @escaping () -> Label){
        self.to = destination
        self.tag = parentTag
        self.label = label
        self.isActive = isActive
    }

    /// The content and behavior of the view.
    public var body: some View{
        if isActive.wrappedValue {navs.dict[tag]?.advance(to); return AnyView(label())}
        return AnyView(Button(action: advance){
            label()
        })
    }
    
    private func advance(){
        navs.dict[tag]?.advance(to)
        isActive.wrappedValue = true
    }
}
