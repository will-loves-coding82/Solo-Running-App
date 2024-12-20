//
//  RunDetailView.swift
//  Solo
//
//  Created by William Kim on 10/28/24.
//

import Foundation
import SwiftUI
import SwiftData

struct ParallaxHeader<Content: View> : View {
    var run: Run!
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        
        GeometryReader { geometry in
            let offset = geometry.frame(in: .global).minY
            let fadeOutOpacity = max(0, 1 - (((offset - 20) * 0.4) / 100))
            
            ZStack {
                content()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                    .offset(y: -offset * 0.8)
//                    .brightness(max(-0.5, min(0.3, offset * 0.01)))
                    
    
                HStack {
                    VStack(alignment: .leading) {
                        Spacer().frame(height: 160)
                        
                        Text("\(convertDateToString(date: run!.startTime)) - \(convertDateToString(date: run!.endTime))")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                        
                        Text("Run Summary")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                        
                        Spacer().frame(height: 12)
                        
                        CapsuleView(
                            iconBackground: nil,
                            iconName: "timer",
                            iconColor: TEXT_LIGHT_GREEN,
                            text: timeDifference(from: run!.startTime, to: run!.endTime)
                        )
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .opacity(fadeOutOpacity)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
      
            }
            .frame(height: 300)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
    }
}
struct RunDetailView: View {
    
    var runData: Run!
        
    var body: some View {
        
        
        ScrollView(showsIndicators: false) {
            
            if let imageData = runData?.routeImage, let uiImage = UIImage(data: imageData) {
                ParallaxHeader(run: runData!) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                }
                .frame(height: 300)
            }
                
                                
            VStack(alignment: .leading) {
            
                Text("Details")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .fontWeight(.semibold)

                
                // Route start and end timeline
                VStack(spacing: 16) {
                    HStack {
                        
                        Circle()
                            .fill(.white)
                            .frame(width: 12, height: 12)
                        
                        
                        Text((runData?.startPlacemark.name)!)
                            .foregroundStyle(TEXT_LIGHT_GREY)
                        
                        Spacer()
                    }
                    .overlay(alignment: .topLeading){
                        Rectangle()
                            .fill(.white)
                            .frame(width: 1.5, height: 32)
                            .offset(y: 16)
                            .padding(.leading, 5.5)
                    }
                    
                    HStack {
                    
                        Circle()
                          .fill(.white)
                          .frame(width: 12, height: 12)
                        
                        Text((runData?.endPlacemark.name)!)
                            .foregroundStyle(TEXT_LIGHT_GREY)
                        
                        Spacer()
                    }
                }

                Spacer().frame(height: 32)
  
                // Run statistics
                HStack {
                    Text("Distance (Meters)")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text((String(format: "%.2f", runData!.distanceTraveled)))
                        .foregroundStyle(.white)
                }
                .padding(20)
                .background(LIGHT_GREY)
                .cornerRadius(12)
                
                HStack {
                    Text("Average Speed (MPH)")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                    
                    Spacer()

                    Text((String(format: "%.2f", runData?.avgSpeed ?? 0)))
                        .foregroundStyle(.white)

                }
                .padding(20)
                .background(LIGHT_GREY)
                .cornerRadius(12)

                HStack {
                    Text("Avg Pace (Min/Mile)")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                    
                    Spacer()

                    Text("\(runData!.avgPace)")
                        .foregroundStyle(.white)

                }
                .padding(20)
                .background(LIGHT_GREY)
                .cornerRadius(12)
                        
                Spacer().frame(height: 48)

                Spacer()
            }
            .padding(.top)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(.black)
            
            

        }
        .defaultScrollAnchor(.bottom)
        .background(.black)
        .toolbarColorScheme(.dark, for: .tabBar)
        .toolbarBackground(.black, for: .tabBar)
        .toolbarBackground(.hidden, for: .navigationBar)
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemMaterialDark)
            appearance.backgroundColor = UIColor(Color.black.opacity(0.2))
        }
    }
    
}

