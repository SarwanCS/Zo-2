//
//  CreateTextSnip.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import SwiftUI

struct CreateTextSnip: View {
    
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var scheme
    
    //@State var showHomeView = false
        
    @State var text = ""
    @State var content = ""
    @ObservedObject var bottomNavigationBarViewModel: BottomNavigationBarViewModel
    
    @EnvironmentObject var dataController: DataController
    @FetchRequest(sortDescriptors: []) var snips: FetchedResults<Snip>
    @Environment(\.managedObjectContext) var moc
    
    @State var defaultsSnip: [Sniptest] = []
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("TextSnipBubble")
                    Spacer()
                }
                Spacer()
            }

            
            VStack{
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(scheme == .dark ? Color("CustomDarkGrey") : Color.white)
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 3)
                        .fill(scheme == .dark ? Color("CustomDarkGrey") : Color.black)
                    HStack{
                        //Subject to change
                        //TextField("Create Text Shortcut...", text: $text)
                        TextEditor(text: $content)
                        Spacer()
                    }.padding()
                        .onAppear {
                            UITextView.appearance().backgroundColor = .clear
                        }
                    
                }.frame(height: 200)

                .padding(.horizontal, 30)
                    .padding(.bottom)

                CustomTextField(text: $text)
                Spacer()
                
                
                Button {
                    
                    let coreDataSnip = Snip(context: moc)
                    
                    coreDataSnip.name = text
                    coreDataSnip.color = "TextSnipColor"
                    coreDataSnip.image = "doc.text.image"
                    coreDataSnip.content = content
                    
                    try? moc.save()
                    
                    updateDefaults()
                    
                    mode.wrappedValue.dismiss()
                    
                    //showHomeView = true
                    
                } label: {
                    CustomCreateButton(text: "CREATE SHORTCUT", borderColor: scheme == .dark ? Color("CustomDarkGrey") : .black , contentColor: scheme == .dark ?  Color("CustomDarkGrey") : .white)
                }.padding(.bottom, 50)

            }.padding(.bottom, 50)
            
            
        }.overlay(
            HStack{
                Text("Text Shortcut")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                Spacer()
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image("cancelButton")
                }.padding(.trailing, 40)
            }
                .padding(.top, 80)
            , alignment: .topTrailing
        ).navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        
        //.fullScreenCover(isPresented: $showHomeView, content: {HomeView()})
        
    }
    func update() {
        for snip in snips {
            let defaultSnip = Sniptest(name: snip.name ?? "", content: snip.content ?? "", color: snip.color ?? "", image: snip.image ?? "", pickedimage: snip.pickedimage ?? Data())
            defaultsSnip.append(defaultSnip)
        
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(defaultsSnip) {
                shareDefault.set(encoded, forKey: "snip")
            }
            
            print(defaultsSnip)
            
        }
    }
    func updateDefaults() {
        let snip = Sniptest(name: text, content: content, color: "TextSnipColor", image: "doc.text.image", pickedimage: Data())

        if let savedSnips = shareDefault.object(forKey: "snip") as? Data {
            let decoder = JSONDecoder()
            if let loadedSnip = try? decoder.decode([Sniptest].self, from: savedSnips) {
                for i in loadedSnip {
                    defaultsSnip.append(i)
                }
                defaultsSnip.append(snip)
            }
        }

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(defaultsSnip) {
            shareDefault.set(encoded, forKey: "snip")
        }
    }
}

/*
struct CreateTextSnip_Previews: PreviewProvider {
    static var previews: some View {
        CreateTextSnip()
            .preferredColorScheme(.light)
    }
}*/

/*
struct CustomTextField: View {
    @Environment(\.colorScheme) var scheme
    @Binding var text: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(scheme == .dark ? Color("CustomDarkGrey") : Color.white)
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3)
                .fill(scheme == .dark ? Color("CustomDarkGrey") : Color.black)
            HStack{
                TextField("Shortcut Name...", text: $text)
                Spacer()
            }.padding()
            
        }
        .frame(height: 60)
        .padding(.horizontal, 30)
            .padding(.bottom, 5)
    }
}*/
