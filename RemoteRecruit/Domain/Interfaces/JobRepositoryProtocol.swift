//
//  JobRepositoryProtocol.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 16/06/2026.
//


import Foundation

/// Defines the data access operations for Jobs.
/// Pure Swift interface for data access.
public protocol JobRepositoryProtocol {
    func fetchJobs() async throws -> [Job]
}
