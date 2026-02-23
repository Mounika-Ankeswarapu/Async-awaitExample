//
//  UsersViewModel.swift
//  AsyncAwaitExample
//
//  Created by Mounika Ankeswarapu on 19/02/26.
//

import Foundation

@MainActor
class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isloading:Bool = false
    @Published var errorMessage:String?
    
    func loadUsers() async {
        isloading = true
        errorMessage = nil
        
        do{
            users = try await APIService.shared.fetchUsers()
        }
        catch{
            errorMessage = error.localizedDescription
        }
        
        isloading = false
    }
}
