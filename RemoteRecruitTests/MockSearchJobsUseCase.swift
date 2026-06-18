//
//  MockSearchJobsUseCase.swift
//  RemoteRecruitTests
//
//  Created by Ajay Mishra on 18/06/2026.
//

import Foundation
@testable import RemoteRecruit

enum MockError: LocalizedError {
    case forcedError
    
    var errorDescription: String? {
        return "Mock Server Error"
    }
}

// 🛑 Change 'struct' to 'final class' here:
final class MockSearchJobsUseCase: SearchJobsUseCaseProtocol {
    var stubbedJobs: [Job] = []
    var shouldThrowError = false
    
    func execute(query: String) async throws -> [Job] {
        if shouldThrowError {
            throw MockError.forcedError
        }
        return stubbedJobs
    }
}
