//
//  ProfileView.swift
//  Solo
//
//  Created by William Kim on 10/14/24.
//

import Foundation
import SwiftUI
import SwiftData

struct ProfileView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var userData: [UserModel]
    var user: UserModel? {userData.first}

    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @AppStorage("isLiveActivityEnabled") var isLiveActivityEnabled = true

    
    var body: some View {
        NavigationStack {


            ScrollView(showsIndicators: false) {
                
                Spacer().frame(height: 96)

                // User profile image
                Group{
                    
                    // Safely unwrap the user's profile picture and check if it's not empty
                    if let profileData = user?.profilePicture, !profileData.isEmpty, let profileImage = UIImage(data: profileData) {
                        Image(uiImage: profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill) // Ensure the image fills the frame
                            .clipped()
                    } else {
                        // If profile picture is empty, show a default person icon
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 64, height: 64)
                        
                    }
                }
                .frame(width: 96, height: 96)
                .background(LIGHT_GREY)
                .clipShape(Circle())
                
                Spacer().frame(height: 12)
                
                // User full name
                if let data = user?.fullName {
                    Text(data)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                } else {
                    Text("user name")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
                
                
                NavigationLink(destination: Text("Edit view")) {
                    Button{} label: {
                        Text("Edit profile")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.small)
                    .tint(DARK_GREY)
                }
                

                Spacer().frame(height: 48)

                
                VStack(alignment: .leading, spacing: 16) {
                    
                    NavigationLink(destination: Text("test")){
                        HStack {
                            VStack(alignment: .leading){
                                Text("Pinned Location")
                                    .foregroundStyle(.white)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text("Manage custom pins for your runs")
                                    .foregroundStyle(TEXT_LIGHT_GREY)
                                    .font(.subheadline)
                            }
                            
                            Spacer()
 
                            Image(systemName: "chevron.right")
                                .foregroundStyle(TEXT_LIGHT_GREY)
                                .frame(width: 24, height: 24)
                        }
                        
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(DARK_GREY))
                    
                    HStack(alignment: .center) {
                        VStack(alignment: .leading){
                            Text("Map Theme")
                                .foregroundStyle(.white)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("Toggle your map theme to dark or light mode")
                                .foregroundStyle(TEXT_LIGHT_GREY)
                                .font(.subheadline)

                        }

                        Spacer()
                        
                        Toggle("", isOn: $isDarkMode)
                            .toggleStyle(SwitchToggleStyle(tint: TEXT_LIGHT_GREY))
                            .frame(maxWidth: 48)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(DARK_GREY))
                    
                    HStack(alignment: .center) {
                        VStack(alignment: .leading){
                            Text("Enable Live Activities")
                                .foregroundStyle(.white)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("Used to display a widget in your notification center")
                                .foregroundStyle(TEXT_LIGHT_GREY)
                                .font(.subheadline)
                        }
                        Spacer()

                        Toggle("", isOn: $isLiveActivityEnabled)
                            .toggleStyle(SwitchToggleStyle(tint: TEXT_LIGHT_GREY))
                            .frame(maxWidth: 48)

                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(DARK_GREY))
                }
                
                Spacer().frame(height: 48)
                
                Button("Delete userData") {
                    Task {
                        let users = try modelContext.fetch(FetchDescriptor<UserModel>())
                        for user in users {
                            modelContext.delete(user)
                        }
                        try modelContext.save()
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
        }
    }
}