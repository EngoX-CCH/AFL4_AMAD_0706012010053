//
//  ContentView.swift
//  CocktailApp
//
//  Created by MacBook Pro on 23/05/22.
//

import SwiftUI

struct Home: View {
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    
    @StateObject var viewModeldrink = ViewModelDrink()
    
    var body: some View {
        
        ScrollView {
            VStack{

                HStack{
                    Text("Recommended Cocktails")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(8.0)
//                        .foregroundColor(.orange)
                    Spacer()
                }
                
                GeometryReader { proxy in
                    TabView(selection: $currentIndex) {
                        ForEach(1..<5) { num in
                            Image("Image\(num)")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(0)
                                .overlay(Color.black.opacity(0.27))
                                .tag(num)
                        }
                    }.tabViewStyle(PageTabViewStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 0))
                    .frame(width: .infinity, height: 250)
                    .onReceive(timer, perform: { _ in
                        withAnimation{
                            currentIndex = currentIndex < 4 ? currentIndex + 1 : 0
                        }
                    })
                }.frame(height: 250)
                .overlay {
                    TextOverlay()
                }

                HStack{
                    Text("Cocktails")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(8.0)
//                        .foregroundColor(.orange)
                    Spacer()
                }

                HStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 0) {
                            ForEach(viewModeldrink.drink, id:\.self){ Drink in
                                HomeDrinkRow(drink: Drink)
                            }
                        }
                    }.onAppear(){
                        viewModeldrink.fetch()
                    }
                    .frame(height: 150)
//                    .background(.gray)
                }

                HStack{
                    Text("Ingredients")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(8.0)
//                        .foregroundColor(.orange)
                    Spacer()
                }

                HStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 0) {
                            ForEach(1..<9) { num in
                                Image("Image-\(num)")
                                    .resizable()
                                    .frame(width: 155, height: 155)
                                    .cornerRadius(5)
//                                    .border(.orange)
//                                    .cornerRadius(15)
//                                    .padding(10)
                            }
                        }
                    }
                }.padding(.bottom, 40)
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
            
    }
}

struct TextOverlay: View {
    
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text("Refreshing cocktails")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.orange)
//                    .underline()
                    
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
//            .background(.black)
    }
}
