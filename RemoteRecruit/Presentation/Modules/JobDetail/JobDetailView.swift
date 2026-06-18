//
//  JobDetailView.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 18/06/2026.
//


import SwiftUI

public struct JobDetailView: View {
    let job: Job
    
    public init(job: Job) {
        self.job = job
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(job.title)
                        .font(.largeTitle)
                        .bold()
                    Text(job.company)
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Meta Info
                HStack(spacing: 20) {
                    Label(job.location, systemImage: "mappin.and.ellipse")
                    Label(job.salaryRange, systemImage: "banknote")
                }
                .font(.callout)
                .foregroundColor(.primary)
                
                Divider()
                
                // Description
                VStack(alignment: .leading, spacing: 12) {
                    Text("About the Role")
                        .font(.headline)
                    Text(job.description)
                        .font(.body)
                        .lineSpacing(4)
                }
                
                // Company Info
                VStack(alignment: .leading, spacing: 12) {
                    Text("About \(job.company)")
                        .font(.headline)
                    Text(job.companyInfo)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(4)
                }
            }
            .padding()
        }
        .navigationTitle("Job Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}