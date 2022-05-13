//
//  PracticeView.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import SwiftUI
import UniformTypeIdentifiers
import MobileCoreServices

class TestClass: ObservableObject {
    @Published var testValue = 0
    
    func testFunc() {
        print("works")
    }
}

struct PracticeView: View {
    @StateObject var testClass = TestClass()
    var body: some View {
        VStack{
            PracticeView3(testClass: testClass)
                .padding(40)
            Button {
                testClass.testValue += 1
            } label: {
                Text("Button")
            }

        }
    }
}

struct PracticeView2: View {
    @ObservedObject var testClass: TestClass
    var body: some View {
        Text("\(testClass.testValue)")
    }
}

struct PracticeView3: View {
    @ObservedObject var testClass: TestClass
    var body: some View {
        PracticeView2(testClass: testClass)
    }
}

struct KeyboardViewTest: View {
    
    //@State private var document: MessageDocument = MessageDocument(message: "Hello, World!")
    @State private var isExporting: Bool = false
    
    let rows = [GridItem(.fixed(150)), GridItem(.adaptive(minimum: 50))]
    var snip: [Sniptest]
    var printOut: (String) -> Void
    
    var body: some View {
        HStack{
            VStack{
                HStack{
                    Text("Your Shortcuts")
                        .font(.system(size: 18, weight: .bold))
                    Spacer()
                }
                if snip.isEmpty {
                    Spacer()
                    Text("You don't have any shortcuts yet.")
                        .bold()
                    Spacer()
                }else{
                    LazyHGrid(rows: rows, alignment: .top, spacing: 20){
                        ForEach(snip, id: \.self){ snip in
                            Button {
                                if snip.color == "ImageSnipColor" {
                                    UIPasteboard.general.setData(snip.pickedimage, forPasteboardType: UTType.png.identifier)
                                }else{
                                    printOut(snip.content)
                                }
                            } label: {
                                HStack{
                                    Image(systemName: snip.image)
                                    Text(snip.name)
                                }
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(snip.color))
                                        .frame(height: 50)
                                )
                                
                            }.frame(maxWidth: .infinity, minHeight: 50)

                        }
                    }
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct Previews_KeyboardViewController_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardViewTest(snip: [Sniptest(name: "test", content: "", color: "TextSnipColor", image: "house", pickedimage: Data()), Sniptest(name: "test", content: "", color: "TextSnipColor", image: "house", pickedimage: Data())]) { _ in
            
        }
    }
}
