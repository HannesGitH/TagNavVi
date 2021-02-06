//
//  SwiftUIView.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI

public struct TagNavigationLink<Label, Destination> : View where Label : View, Destination : View {
    
    @EnvironmentObject var nav: NavigationStack
    
    private var to : Destination
    private var label : ()->Label
    private var isActive : Binding<Bool>
    
    /// Creates an instance that presents `destination`.
    init(destination: Destination, @ViewBuilder label: @escaping () -> Label){
        self.to = destination
        self.label = label
        self.isActive = .constant(false)
    }

    /// Creates an instance that presents `destination` when active.
    init(destination: Destination, isActive: Binding<Bool>, @ViewBuilder label: @escaping () -> Label){
        self.to = destination
        self.label = label
        self.isActive = isActive
    }

    /// The content and behavior of the view.
    var body: some View{
        if isActive.wrappedValue {nav.advance(NavigationItem(to)); return AnyView(label())}
        return AnyView(Button(action: advance){
            label()
        })
    }
    
    private func advance(){
        nav.advance(NavigationItem(to))
        isActive.wrappedValue = true
    }
}
