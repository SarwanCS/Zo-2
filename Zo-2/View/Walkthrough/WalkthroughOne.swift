//
//  WalkthroughOne.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import SwiftUI

struct WalkthroughOne: View {
    @Binding var isSkipped: Bool
    @AppStorage("firstTime") var firstTime = true
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("UpperBubble")
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    Image("LowerBubble")
                }
                
            }
            VStack{
                Spacer()
                VStack{
                    HStack{
                        Image("Snip-4")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170)
                        Image("Snip-1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170)
                    }
                    HStack{
                        Image("Snip-2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170)
                        Image("Snip-3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170)
                    }

                    Text("Create Shortcuts.")
                        .font(.system(size: 30, weight: .bold))
                        .padding(.top, 80)
                        .padding(.bottom, 2)
                    Text("Constantly sharing the same pictures, text, phrases, files or links? Create a Snip")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }.padding(.top, 90)
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
                            .frame(width: 15, height: 15)
                        Circle()
                            .fill(Color(UIColor.systemGray5))
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

struct WalkthroughOne_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughOne(isSkipped: .constant(false))
    }
}
