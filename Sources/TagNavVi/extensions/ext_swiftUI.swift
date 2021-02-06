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
    func opens<UI:View,Tag:Hashable>( _ view : UI , on : Binding<Bool>, with tag : Tag)->some View{
        ZStack{
            TagNavigationLink(parentTag: tag, destination: view, isActive: on) {
                EmptyView()
            }
            self
        }
    }
}
