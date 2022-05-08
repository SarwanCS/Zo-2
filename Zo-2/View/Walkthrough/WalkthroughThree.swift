//
//  WalkthroughThree.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import SwiftUI

struct WalkthroughThree: View {
    @Binding var isSkipped: Bool
    @AppStorage("firstTime") var firstTime = true
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("UpperBubble2")
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    Image("LowerBubble2")
                }
                
            }
            VStack{
                Spacer()
                VStack{
                    Image("Phone")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                    Text("Using Shortcuts")
                        .font(.system(size: 30, weight: .bold))
                        .padding(.top, 60)
                        .padding(.bottom, 2)
                    Text("Toggle Zo's keyboard and tap the shortcut you want to use.")
                        //.underline()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                Spacer()
                VStack{
                    Button {
                        withAnimation {
                            isSkipped = true
                            firstTime = false
                        }
                    } label: {
                        Image("completeButton")
                            .resizable()
                            //.scaledToFit()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 130)
                    }

                    HStack(spacing: 10){
                        Circle()
                            .fill(Color(UIColor.systemGray5))
                            .frame(width: 15, height: 15)
                        Circle()
                            .fill(Color(UIColor.systemGray5))
                            .frame(width: 15, height: 15)
                        Circle()
                            
                            .frame(width: 15, height: 15)
                    }.padding(.top, 30)
                }.padding(.bottom, 50)
            }
            
            
                
        }.ignoresSafeArea()
    }
}

struct WalkthroughThree_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughThree(isSkipped: .constant(false))
    }
}
