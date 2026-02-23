//
//  NetworkLayer.swift
//  AsyncAwaitExample
//
//  Created by Mounika Ankeswarapu on 19/02/26.
//

import Foundation

final class APIService{
    static let shared = APIService()
    private init() {}
    
    func fetchUsers() async throws -> [User] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpresponse = response as? HTTPURLResponse,
              200..<300 ~= httpresponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        
        return try JSONDecoder().decode([User].self, from: data)
        
    }
    
    func fetchUserDetail(id: Int) async throws -> User {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(id)")!
        let (data,_) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(User.self, from: data)
    }
    
}


