//
//  ContentView.swift
//  Solo
//
//  Created by William Kim on 10/13/24.
//

import SwiftUI
import SwiftData


struct SplashScreenView<Content: View>: View {
        
    var content: Content
    var onAnimationEnd: ()->()
    var color: String
    var logo: String
    init(color:String, logo:String, @ViewBuilder content: @escaping () -> Content, onAnimationEnd: @escaping () -> ()) {
        self.color = color
        self.onAnimationEnd = onAnimationEnd
        self.logo = logo
        self.content = content()
    }
    
    var body: some View {
        
        VStack{
            
            // Logo here
            Text("SOLO")
                .font(Font.custom("Koulen-Regular", size: 48))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundStyle(NEON)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) 
        .background(.black)
       
    }
}

#Preview
struct 
{
        SplashScreenView()
}


//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext

//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}