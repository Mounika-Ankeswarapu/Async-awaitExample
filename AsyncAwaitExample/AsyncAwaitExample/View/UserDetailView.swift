//
//  UserDetailView.swift
//  AsyncAwaitExample
//
//  Created by Mounika Ankeswarapu on 19/02/26.
//

import SwiftUI

struct UserDetailView: View {
    
    let userID:Int
    
    @State private var user:User?
    @State private var isLoading:Bool = true
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 20){
            if isLoading {
                ProgressView()
            }
            else if let error = errorMessage{
                Text(error)
                    .foregroundStyle(.red)
            }
            else if let user = user{
                VStack(spacing: 20){
                    Text(user.name)
                        .font(.title)
                    Text(user.email)
                    Text(user.phone)
                    Text("Hi")
                    
                }
            }
        }
        .padding()
        .task {
            await loadDetail()
        }
    }
    
    func loadDetail() async{
        do{
            user = try await APIService.shared.fetchUserDetail(id: userID)
        }
        catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}


