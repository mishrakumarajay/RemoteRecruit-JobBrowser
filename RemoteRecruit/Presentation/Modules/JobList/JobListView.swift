//
//  JobListView.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 18/06/2026.
//


import SwiftUI

public struct JobListView: View {
    @StateObject private var viewModel: JobListViewModel
    
    // Injecting the ViewModel
    public init(viewModel: JobListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView("Searching for opportunities...")
                        .controlSize(.large)
                    
                case .empty:
                    ContentUnavailableView(
                        "No Jobs Found",
                        systemImage: "magnifyingglass",
                        description: Text("Try adjusting your search terms.")
                    )
                    
                case .failure(let errorMsg):
                    ContentUnavailableView(
                        "Connection Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMsg)
                    )
                    
                case .success(let jobs):
                    List(jobs) { jobViewModel in
                        NavigationLink(destination: JobDetailView(job: jobViewModel.rawJob)) {
                            JobRowView(viewModel: jobViewModel)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Remote Recruit")
            .searchable(text: $viewModel.searchQuery, prompt: "Search by title or company")
            .task {
                await viewModel.loadJobs()
            }
        }
    }
}