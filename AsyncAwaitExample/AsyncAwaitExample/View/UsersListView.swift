//
//  UsersListView.swift
//  AsyncAwaitExample
//
//  Created by Mounika Ankeswarapu on 19/02/26.
//

import SwiftUI

struct UsersListView: View {
    @StateObject private var viewModel = UsersViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isloading {
                    ProgressView("Loading...")
                }
                else if let error = viewModel.errorMessage{
                    VStack{
                        Text("Error")
                        Text(error)
                            .foregroundStyle(.red)
                    }
                }
                else{
                    List(viewModel.users){ user in
                        NavigationLink(value: user.id){
                            VStack(alignment: .leading){
                                Text(user.name)
                                    .font(.headline)
                                Text(user.email)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.loadUsers()
                    }
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: Int.self){ userID in
                UserDetailView(userID: userID)
                
            }
        }
        .task {
            await viewModel.loadUsers()
        }
    }
}

#Preview {
    UsersListView()
}
