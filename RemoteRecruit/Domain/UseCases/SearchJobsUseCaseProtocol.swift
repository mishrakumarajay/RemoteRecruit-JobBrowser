//
//  SearchJobsUseCaseProtocol.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 16/06/2026.
//


import Foundation

public protocol SearchJobsUseCaseProtocol: Sendable {
    func execute(query: String) async throws -> [Job]
}

public actor SearchJobsUseCase: SearchJobsUseCaseProtocol {
    private let repository: JobRepositoryProtocol
    
    // Injecting the repository abstraction
    public init(repository: JobRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(query: String) async throws -> [Job] {
        let allJobs = try await repository.fetchJobs()
        
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return allJobs
        }
        
        return allJobs.filter { job in
            job.title.localizedCaseInsensitiveContains(query) ||
            job.company.localizedCaseInsensitiveContains(query)
        }
    }
}