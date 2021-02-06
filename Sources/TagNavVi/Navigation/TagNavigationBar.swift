//
//  SwiftUIView.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI

//TODO add to navigationView
public struct TagNavigationBar<Tag:Hashable,HeadlineV:View>:View{
    
    @EnvironmentObject var navs: NavigationStackCollection<Tag>
    var nav : NavigationStack<Tag> {navs.dict[tag]!}
    
    let headline:()->HeadlineV
    let withHomeButton:Bool
    let tag : Tag
    
    init(
        tag : Tag,
        withHomeButton : Bool = false,
        @ViewBuilder _ headline: @escaping () -> HeadlineV
    ) {
        self.headline = headline
        self.withHomeButton = withHomeButton
        self.tag = tag
    }
    
    public var body: some View {
        HStack{
            backButton
            headline().font(.headline)
        }
    }
        
    @ViewBuilder private var backButton:some View{Group{
        if !nav.isHome{
            Button( action: nav.unwind){
                //Image(systemName: "arrow.backward")
                Text("􀎞") //wtf macos?
            }
            //Spacer().frame(width: 10)
            Button( action: nav.unwind){
               //Image(systemName: "house")
                Text("􀄪") //wtf macos?
            }
        }}
        .padding(.trailing, 20)
    }
}


struct CNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TagNavigationBar(tag:"tag1"){"title"}
    }
}
