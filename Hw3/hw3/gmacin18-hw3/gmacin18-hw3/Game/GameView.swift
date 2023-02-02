//
//  ContentView.swift
//  gmacin18-hw3
//
//  Created by User on 4.01.2023.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    @State private var infoPresented = false
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    drawView
                }
                Spacer()
                drawButton
                Spacer()
                infoButton
                
            }.sheet(isPresented: $infoPresented, content: {
                InfoView()
            })
            .navigationTitle("Draw Application").navigationBarTitleDisplayMode(.inline)
        }
    }
    private var infoButton: some View{
        HStack{
            Button("INFO") {
                infoPresented.toggle()
            }
            
        }
    }
    private var drawButton: some View{
        Button(action: {
            viewModel.drawNames()
        }, label: {
            Text(viewModel.buttonTitle).padding(25)
        }).background(Color.blue)
            .cornerRadius(10)
            .shadow(color: .blue, radius: 5)
            .foregroundColor(Color.white).padding(25)
    }
    private var drawView: some
    View {
        VStack{
            ForEach(viewModel.shownNames, id: \.self) { name in Text(name).foregroundColor(Color.blue).bold(true) }
        }
    }
 
}
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
