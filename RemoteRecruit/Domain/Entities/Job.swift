//
//  Job.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 16/06/2026.
//


import Foundation

/// Represents a job opportunity in the system.
/// Conforms to `Sendable` for safe passing across concurrency domains.
public struct Job: Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let company: String
    public let location: String
    public let salaryRange: String
    public let description: String
    public let companyInfo: String
    
    public init(id: String, title: String, company: String, location: String, salaryRange: String, description: String, companyInfo: String) {
        self.id = id
        self.title = title
        self.company = company
        self.location = location
        self.salaryRange = salaryRange
        self.description = description
        self.companyInfo = companyInfo
    }
}