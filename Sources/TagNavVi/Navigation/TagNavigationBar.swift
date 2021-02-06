//
//  SwiftUIView.swift
//  
//
//  Created by hanneh00 on 06.02.21.
//

import SwiftUI

//TODO add to navigationView
public struct TagNavigationBar<HeadlineV:View>:View{
    
    @EnvironmentObject var nav: NavigationStack
    
    let headline:()->HeadlineV
    let withHomeButton:Bool
    
    init(
        withHomeButton : Bool = false,
        @ViewBuilder _ headline: @escaping () -> HeadlineV
    ) {
        self.headline = headline
        self.withHomeButton = withHomeButton
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
        TagNavigationBar{"title"}
    }
}
