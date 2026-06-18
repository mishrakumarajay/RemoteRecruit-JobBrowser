//
//  JobListViewModel.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 18/06/2026.
//


import Foundation
import Combine

@MainActor
public final class JobListViewModel: ObservableObject {
    @Published public private(set) var state: UIState<[JobItemViewModel]> = .idle
    @Published public var searchQuery: String = ""
    
    private let searchUseCase: SearchJobsUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // Dependency Injection
    public init(searchUseCase: SearchJobsUseCaseProtocol) {
        self.searchUseCase = searchUseCase
        setupSearchDebounce()
    }
    
    /// Initial load of all available jobs
    public func loadJobs() async {
        state = .loading
        await performSearch(query: "")
    }
    
    /// Uses Combine to debounce typing. If the user types fast, it won't trigger
    /// a search on every single letter, saving processing power.
    private func setupSearchDebounce() {
        $searchQuery
            // Wait 0.3 seconds after the user stops typing
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            // Ignore if the text hasn't changed
            .removeDuplicates()
            // We skip the first empty event when the view loads
            .dropFirst()
            .sink { [weak self] query in
                guard let self = self else { return }
                
                // Wrap the async call in a Task because sink is synchronous
                Task {
                    self.state = .loading
                    await self.performSearch(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(query: String) async {
        do {
            let domainJobs = try await searchUseCase.execute(query: query)
            
            if domainJobs.isEmpty {
                state = .empty
            } else {
                let viewModels = domainJobs.map { JobItemViewModel(job: $0) }
                state = .success(viewModels)
            }
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}