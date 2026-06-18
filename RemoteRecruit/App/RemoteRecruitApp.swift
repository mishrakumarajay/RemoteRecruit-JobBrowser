//
//  RemoteRecruitApp.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 16/06/2026.
//

import SwiftUI

@main
struct RemoteRecruitApp: App {
    let searchUseCase: SearchJobsUseCase
    
    init() {
        // 1. Initialize the Data Layer (The Infrastructure)
        let repository = LocalJobRepository(fileName: "jobs_mock")
        
        // 2. Initialize the Domain Layer (The Business Rules)
        self.searchUseCase = SearchJobsUseCase(repository: repository)
    }
    
    var body: some Scene {
        WindowGroup {
            // 3. Inject the Domain into the Presentation Layer (The UI)
            JobListView(viewModel: JobListViewModel(searchUseCase: searchUseCase))
        }
    }
}
