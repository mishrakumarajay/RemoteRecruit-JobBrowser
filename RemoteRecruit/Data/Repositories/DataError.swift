//
//  DataError.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 18/06/2026.
//


import Foundation

public enum DataError: LocalizedError {
    case fileNotFound
    case decodingFailed
    
    public var errorDescription: String? {
        switch self {
        case .fileNotFound: return "The local mock data file could not be located."
        case .decodingFailed: return "Failed to parse the mock data into expected models."
        }
    }
}

public actor LocalJobRepository: JobRepositoryProtocol {
    private let fileName: String
    
    public init(fileName: String = "jobs_mock") {
        self.fileName = fileName
    }
    
    public func fetchJobs() async throws -> [Job] {
        // Simulating a minor network latency to demonstrate the UI loading state
        try await Task.sleep(nanoseconds: 600_000_000)
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw DataError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let dtos = try decoder.decode([JobDTO].self, from: data)
            
            // Map the DTOs to Domain Entities before returning
            return dtos.map { $0.toDomain() }
        } catch {
            throw DataError.decodingFailed
        }
    }
}