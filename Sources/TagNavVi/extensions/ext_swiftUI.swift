//
//  SwiftUIView 2.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI

//add empty init to anyView
public extension AnyView{
    init(){
        self.init(EmptyView())
    }
}

public extension Image{
    /// resize image to fit a sqaure of given size
    @ViewBuilder func sizeTo(_ iconSize:CGFloat? = nil)->some View{
        if let size = iconSize {
            self
                .resizable().scaledToFit()
                .frame(width: size, height: size, alignment: .center)
        } else {self}
    }
}

//a String is now a View
extension String : View {
    public var body: some View {
        Text(self)
    }
}

public extension View {
    func opens<UI:View,Tag:Hashable>( _ view : UI , on pressed : Binding<Bool>, with tag : Tag)->some View{
        ZStack{
            TagNavigationLink(parentTag: tag, destination: view, isActive: pressed) {
                EmptyView()
            }
            self
        }
    }
    func openOnTap<Destination:View, Tag:Hashable>(
        tag             : Tag,
        _ destination   : @escaping () -> Destination
    )->some View{
        return OnTapOpener(
            home: self,
            destination: destination,
            tag: tag
        )
    }
}

fileprivate struct OnTapOpener<Home:View,Destination:View, Tag:Hashable> : View {
    
    @State var isPressed: Bool = false
    
    let home        : Home
    let destination : ()->Destination
    let tag         : Tag
    
    var body: some View {
        home
            .onTapGesture {
                isPressed.toggle()
            }
            .opens(destination(), on: $isPressed, with: tag)
    }
}
