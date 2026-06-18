//
//  JobItemViewModel.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 18/06/2026.
//


import Foundation

/// A presentation model wrapping the domain `Job` entity for UI consumption.
public struct JobItemViewModel: Identifiable, Equatable {
    public let id: String
    public let title: String
    public let company: String
    public let location: String
    public let salaryRange: String
    
    // We hold a reference to the raw entity for passing to detail views
    public let rawJob: Job
    
    public init(job: Job) {
        self.id = job.id
        self.title = job.title
        self.company = job.company
        self.location = job.location
        self.salaryRange = job.salaryRange
        self.rawJob = job
    }
    
    // Equatable conformance required for the UIState enum
    public static func == (lhs: JobItemViewModel, rhs: JobItemViewModel) -> Bool {
        lhs.id == rhs.id
    }
}