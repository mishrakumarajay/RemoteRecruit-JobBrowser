//
//  MockSearchJobsUseCase.swift
//  RemoteRecruitTests
//
//  Created by Ajay Mishra on 18/06/2026.
//

import Foundation
@testable import RemoteRecruit

// A mock that allows us to control exactly what data is returned during tests
struct MockSearchJobsUseCase: SearchJobsUseCaseProtocol {
    var stubbedJobs: [Job] = []
    var shouldThrowError = false
    
    func execute(query: String) async throws -> [Job] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock Server Error"])
        }
        return stubbedJobs
    }
}
