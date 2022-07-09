//
//  ContentView.swift
//  Enemy Loses
//
//  Created by Alex Shbeir on 09.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State var currentTab = "newspaper.fill"
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    // Curve Axis Value
    @State var curveAxis: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Text("News")
                    .tag("newspaper.fill")
                
                Text("Personell")
                    .tag("person.fill")
                
                Text("Equipment")
                    .tag("airplane")
                
                Text("Map")
                    .tag("map.fill")
            }
            .clipShape(CustomTabCurve(curveAxis: curveAxis))
            .padding(.bottom, -80)
            
            HStack(spacing: 0) {
                TabButtons()
            }
            .frame(height: 30)
            .padding(.horizontal, 35)
        } //: VStack
        .background(Color.blue.opacity(0.9))
        .ignoresSafeArea(.container, edges: .top)
    }
    
    @ViewBuilder
    func TabButtons() -> some View {
        ForEach(["newspaper.fill", "person.fill", "airplane", "map.fill"], id: \.self) { image in
            
            GeometryReader { proxy in
                Button {
                    withAnimation {
                        currentTab = image
                        curveAxis = proxy.frame(in: .global).midX
                    }
                } label: {
                    Image(systemName: image)
                        .font(.title2)
                        .foregroundColor(Color.blue.opacity(0.9))
                        .frame(width: 45, height: 45)
                        .background(
                            Circle()
                                .fill(Color.yellow)
                        )
                        .offset(y: currentTab == image ? -25 : 0)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                // initial update
                .onAppear {
                    if curveAxis == 0, image == "newspaper.fill" {
                        curveAxis = proxy.frame(in: .global).midX
                    }
                }
            }.frame(height: 40)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
