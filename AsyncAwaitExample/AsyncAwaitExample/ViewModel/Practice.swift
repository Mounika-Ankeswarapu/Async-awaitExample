//
//  Practice.swift
//  AsyncAwaitExample
//
//  Created by Mounika Ankeswarapu on 20/02/26.
//

import Foundation

class Practice {
    static let shared = Practice()
    private init() {}
    
    func fetchData() async throws -> [User]{
        let url = URL(string: "")!
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode([User].self, from: data)
    }
}
