//
//  MockSearchJobsUseCase.swift
//  RemoteRecruitTests
//
//  Created by Ajay Mishra on 18/06/2026.
//

import Foundation
@testable import RemoteRecruit

// A clean error type to prevent NSError from mangling our string
enum MockError: LocalizedError {
    case forcedError
    
    var errorDescription: String? {
        return "Mock Server Error"
    }
}

// The updated mock use case
struct MockSearchJobsUseCase: SearchJobsUseCaseProtocol {
    var stubbedJobs: [Job] = []
    var shouldThrowError = false
    
    func execute(query: String) async throws -> [Job] {
        if shouldThrowError {
            throw MockError.forcedError
        }
        return stubbedJobs
    }
}
