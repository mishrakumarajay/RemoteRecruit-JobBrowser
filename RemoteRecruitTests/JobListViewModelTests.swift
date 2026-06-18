//
//  JobListViewModelTests.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 18/06/2026.
//


import XCTest
import Combine
@testable import RemoteRecruit

@MainActor
final class JobListViewModelTests: XCTestCase {
    private var sut: JobListViewModel!
    private var mockUseCase: MockSearchJobsUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockSearchJobsUseCase()
        sut = JobListViewModel(searchUseCase: mockUseCase)
    }
    
    override func tearDown() {
        sut = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func test_loadJobs_withValidData_updatesStateToSuccess() async {
        // Arrange
        let expectedJob = Job(id: "1", title: "Test Engineer", company: "Apple", location: "US", salaryRange: "100k", description: "Desc", companyInfo: "Info")
        mockUseCase.stubbedJobs = [expectedJob]
        
        // Act
        await sut.loadJobs()
        
        // Assert
        let expectedViewModel = JobItemViewModel(job: expectedJob)
        
        // Explicitly typing the expected state fixes compiler ambiguity
        let expectedState: UIState<[JobItemViewModel]> = .success([expectedViewModel])
        
        XCTAssertEqual(sut.state, expectedState)
    }
    
    func test_loadJobs_withError_updatesStateToFailure() async {
        // Arrange
        mockUseCase.shouldThrowError = true
        
        // Act
        await sut.loadJobs()
        
        // Assert
        // Explicitly typing the expected state ensures the compiler knows 'T' is [JobItemViewModel]
        let expectedState: UIState<[JobItemViewModel]> = .failure("Mock Server Error")
        
        XCTAssertEqual(sut.state, expectedState)
    }
    
    func test_loadJobs_withEmptyData_updatesStateToEmpty() async {
        // Arrange
        mockUseCase.stubbedJobs = []
        
        // Act
        await sut.loadJobs()
        
        // Assert
        XCTAssertEqual(sut.state, .empty)
    }
    
}
