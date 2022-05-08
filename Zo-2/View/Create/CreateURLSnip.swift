//
//  CreateURLSnip.swift
//  Zo
//
//  Created by Brian Heralall on 1/31/2022.
//

import SwiftUI

struct CreateURLSnip: View {
    
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var scheme
    
    @State var text = ""
    @State var url = ""

    @EnvironmentObject var dataController: DataController
    @FetchRequest(sortDescriptors: []) var snips: FetchedResults<Snip>
    @Environment(\.managedObjectContext) var moc
    
    @State var defaultsSnip: [Sniptest] = []
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("URLSnipBubble")
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
                        TextField("Paste URL Here...", text: $url)
                        Spacer()
                    }.padding()
                    
                }
                .frame(height: 60)
                .padding(.horizontal, 30)
                    .padding(.bottom, 5)
                   

                CustomTextField(text: $text)
                Spacer()
                
                
                Button {
                    let coreDataSnip = Snip(context: moc)
                    
                    coreDataSnip.name = text
                    coreDataSnip.color = "URLSnipColor"
                    coreDataSnip.image = "paperclip"
                    coreDataSnip.content = url
                    
                    try? moc.save()
                    
                    updateDefaults()
                    
                    mode.wrappedValue.dismiss()
                } label: {
                    CustomCreateButton(text: "CREATE SHORTCUT", borderColor: scheme == .dark ? Color("CustomDarkGrey") : .black , contentColor: scheme == .dark ?  Color("CustomDarkGrey") : .white)
                }.padding(.bottom, 50)

            }.padding(.bottom, 50)
            
            
        }.overlay(
            HStack{
                Text("URL Shortcut")
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
    }
    func updateDefaults() {
        let snip = Sniptest(name: text, content: url, color: "URLSnipColor", image: "paperclip", picked: Data())

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

struct CreateURLSnip_Previews: PreviewProvider {
    static var previews: some View {
        CreateURLSnip()
            .preferredColorScheme(.light)
    }
}
