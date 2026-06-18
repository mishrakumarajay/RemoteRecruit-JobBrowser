//
//  JobRowView.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 18/06/2026.
//


import SwiftUI

public struct JobRowView: View {
    let viewModel: JobItemViewModel
    
    public init(viewModel: JobItemViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(viewModel.company)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Label(viewModel.location, systemImage: "mappin.and.ellipse")
                Spacer()
                Label(viewModel.salaryRange, systemImage: "banknote")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.top, 4)
        }
        .padding(.vertical, 8)
    }
}