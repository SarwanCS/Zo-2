//
//  walktap.swift
//  Zo-2
//
//  Created by administrator on 5/6/22.
// ignore this file test code

/*
import SwiftUI

struct walktap:View {
    
    @Environment(\.colorScheme) var scheme
    @State var offsetOfFirstOne = CGSize.zero
    @State var offsetOfSecondOne = CGSize.zero
    @State var offsetOfThirdOne = CGSize.zero
    
    @AppStorage("firstTime") var firstTime = true
    
    @Binding var loggedIn: Bool
    
    @State var isSkipped = false
    @State var isFinished = false
    
    var body: some View{
        ZStack{
            if isSkipped {
                SignUpView(loggedIn: $loggedIn)
            }else{
                ZStack{
                    SignUpView(loggedIn: $loggedIn)
                    WalkthroughThree(isSkipped: $isSkipped)
                        .background(scheme == .dark ? .black : .white)
                        .zIndex(1)
                        .offset(x: offsetOfThirdOne.width)
                        .onTapGesture {
                            withAnimation {
                                offsetOfThirdOne.width = 0
                                isFinished = true
                                firstTime = false
                            }
                        }
                        .disabled(isFinished)
                    
                    WalkthroughTwo(isSkipped: $isSkipped)
                        .background(scheme == .dark ? .black : .white)
                        .zIndex(2)
                        .offset(x: offsetOfSecondOne.width)
                        .onTapGesture {
                            
                            withAnimation {
                                offsetOfSecondOne.width = 0
                            }
                            
                        }
                    
                    
                        .disabled(isFinished)
                    
                    WalkthroughOne(isSkipped: $isSkipped)
                        .background(scheme == .dark ? .black : .white)
                        .offset(x: offsetOfFirstOne.width)
                        .zIndex(3)
                        .onTapGesture {
                            
                            withAnimation {
                                offsetOfFirstOne.width = 0
                            }
                            
                        }
                        .disabled(isFinished)
                    
                }
                
                
            }
            
        }
        
    }
    
    
    
} */
