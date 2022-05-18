//
//  WalkthroughTwo.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import SwiftUI

struct WalkthroughTwo: View {
    @Binding var isSkipped: Bool
    @AppStorage("firstTime") var firstTime = true
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("UpperBubble1")
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    Image("LowerBubble1")
                }
                
            }
            VStack{
                Spacer()
                VStack{
                    ZStack{
                        Image("WalkthroughTwoBackground")
                        ZStack(alignment: .top){
                            Image("WalkthroughTwoKeyboard")
                                .resizable()
                                //.scaledToFit()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350)
                            ZStack{
                                Image("WalkthroughTwoBackground")
                                    .resizable()
                                    //.scaledToFit()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 350)
                                VStack(alignment: .leading){
                                    Image("YourSnips")
                                        .resizable()
                                        //.scaledToFit()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70)
                                    Image("WalkthroughTwoContent")
                                        .resizable()
                                        //.scaledToFit()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 280)
                                }
                            }
                            
                        }
                    }.padding(.top, 80)
                    Text("Accessing Shortcuts.")
                        .font(.system(size: 30, weight: .bold))
                        .padding(.top, 150)
                        .padding(.bottom, 2)
                    Text("Activate ZoZo's keyboard in your settings to access the Shortcuts you create inside ZoZo.")
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
                        Image("skipButton")
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
                            .frame(width: 15, height: 15)
                        Circle()
                            .fill(Color(UIColor.systemGray5))
                            .frame(width: 15, height: 15)
                    }.padding(.top, 30)
                }.padding(.bottom, 50)
            }
            
            
            
        }.ignoresSafeArea()
        
    }
}

struct Walkthrough2_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughTwo(isSkipped: .constant(false))
    }
}
