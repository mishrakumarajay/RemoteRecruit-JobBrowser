//
//  JobRepositoryProtocol.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 16/06/2026.
//


import Foundation

/// Defines the data access operations for Jobs.
public protocol JobRepositoryProtocol: Sendable {
    /// Fetches a list of available jobs.
    /// - Returns: An array of `Job` entities.
    /// - Throws: An error if the data cannot be retrieved.
    func fetchJobs() async throws -> [Job]
}