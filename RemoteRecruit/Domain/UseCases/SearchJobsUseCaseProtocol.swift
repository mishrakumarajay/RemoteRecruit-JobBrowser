//
//  SearchJobsUseCaseProtocol.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 16/06/2026.
//


public protocol SearchJobsUseCaseProtocol {
    func execute(query: String) async throws -> [Job]
}

public struct SearchJobsUseCase: SearchJobsUseCaseProtocol {
    private let repository: JobRepositoryProtocol
    
    public init(repository: JobRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(query: String) async throws -> [Job] {
        let allJobs = try await repository.fetchJobs()
        
        // Pure Swift check for empty or whitespace-only strings
        let isQueryEmpty = query.filter { $0 != " " }.isEmpty
        guard !isQueryEmpty else {
            return allJobs
        }
        
        let searchTarget = query.lowercased()
        
        // Pure Swift string search
        return allJobs.filter { job in
            job.title.lowercased().contains(searchTarget) ||
            job.company.lowercased().contains(searchTarget)
        }
    }
}
