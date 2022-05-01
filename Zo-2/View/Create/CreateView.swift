//
//  CreateView.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import SwiftUI

struct CreateView: View {
    @State var show = false
    @ObservedObject var bottomNavigationBarViewModel: BottomNavigationBarViewModel
    @State var showTextSnip = false
    @State var showURLSnip = false
    @State var showDocumentSnip = false
    @State var showPhotoSnip = false
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    HStack{
                        Image("CreateSnipBubble")
                        Spacer()
                    }
                    Spacer()
                }
                VStack{
                    HStack{
                        Button {
                           showTextSnip = true
                        } label: {
                            CreateViewCell(image: "doc.text.image", color: "TextSnipColor", name: "Text Shortcut")
                        }
                        Button {
                           showURLSnip = true
                        } label: {
                            CreateViewCell(image: "paperclip", color: "URLSnipColor", name: "URL Shortcut")
                        }
                    }
                    HStack{
                        Button {
                           showPhotoSnip = true
                        } label: {
                            CreateViewCell(image: "photo", color: "ImageSnipColor", name: "Photo Shortcut")
                        }
                        Button {
                           showDocumentSnip = true
                        } label: {
                            CreateViewCell(image: "doc.fill", color: "DocumentSnipColor", name: "Document Shortcut")
                        }

                    }
                    Text("Choose the type of Shortcut you want to create. You can access your Shortcuts at anytime by activating the Zo Keyboard in your settings")
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal, 35)
                }.padding(.top, 80)
            }.navigationTitle("Create")
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $showTextSnip, content: {CreateTextSnip(bottomNavigationBarViewModel: bottomNavigationBarViewModel)})
            .fullScreenCover(isPresented: $showURLSnip, content: {CreateURLSnip()})
            .fullScreenCover(isPresented: $showPhotoSnip, content: {CreatePhotoSnip()})
            .fullScreenCover(isPresented: $showDocumentSnip, content: {CreateDocumentSnip()})
        }
    }
}

struct CustomCreateButton: View {
    let text: String
    let borderColor: Color
    let contentColor: Color
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(contentColor)
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3)
                .fill(borderColor)
                
            HStack{
                Text(text)
                    .bold()
            }.foregroundColor(scheme == .dark ? Color(.white) : Color(.black))
        }.frame(height: 60)
        .padding(.horizontal, 30)
            .padding(.bottom, 5)
    }
}

struct CreateViewCell: View {
    let image: String
    let color: String
    let name: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(color))
                .frame(width: 160, height: 160)
            VStack{
                Image(systemName: image)
                    .font(.system(size: 35, weight: .bold))
                Text(name)
                    .font(.system(size: 15, weight: .bold))
                    .padding(.top, 15)
                
            }.foregroundColor(.white)
            
        }
    }
}
