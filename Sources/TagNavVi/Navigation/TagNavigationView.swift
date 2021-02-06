//
//  SwiftUIView.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI

//TODO: add navigationBar
public struct TagNavigationView<Tag:Hashable> : View {

    @EnvironmentObject var navs: NavigationStackCollection<Tag>
    let tag : Tag
    
    var newStack:(k:Tag,v:NavigationStack<Tag>)?
    
    public init<Content:View>(tag : Tag , @ViewBuilder _ content: () -> Content){
        self.tag = tag
        newStack = (
            k:tag,
            v:NavigationStack(
                tag: tag,
                NavigationItem(
                    content()
                )
            )
        )
    }
    var currentContent : AnyView {
        let x = navs.dict[tag]?.currentView.view ??
            AnyView()
        return x
    }
    var headline : AnyView?
    var withHomeButton = false
    public var body: some View{
        navs.append(k:newStack?.k ?? tag, v:newStack?.v ?? NavigationStack(tag: tag, NavigationItem("mist")))
        return VStack{
            if let hl = headline {
                TagNavigationBar(tag: tag, withHomeButton : withHomeButton){
                    hl
                }
            }
            currentContent
            Spacer()
        }
    }
    
}

extension TagNavigationView{
    
    init(
        tag : Tag ,
        headline : AnyView,
        withHomeButton: Bool,
        newStack : (k:Tag,v:NavigationStack<Tag>)?
        
    ){
        self.headline=headline
        self.withHomeButton=withHomeButton
        self.tag = tag
        self.newStack = newStack
    }
    
    public func withTitle<HeadlineV:View>(
        withHomeButton : Bool = false,
        @ViewBuilder _ headline: @escaping () -> HeadlineV
    )->some View{
        return TagNavigationView(
            tag: self.tag,
            headline : AnyView(headline()),
            withHomeButton: withHomeButton,
            newStack: self.newStack
        )
    }
}


extension View {
    func home<Tag:Hashable>(_ k : Tag, _ v: AnyView = AnyView(Text("kein inhalt")))->some View{
        self.environmentObject(NavigationStackCollection([k:NavigationStack(tag: k, NavigationItem(v))]).observeChildrenChanges())
    }
}
