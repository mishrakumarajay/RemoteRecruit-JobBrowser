//
//  JobDTO.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 18/06/2026.
//


import Foundation

struct JobDTO: Decodable {
    let id: String
    let title: String
    let company: String
    let location: String
    let salaryRange: String
    let description: String
    let companyInfo: String
    
    // Mapper to convert DTO to our pure Domain Entity
    func toDomain() -> Job {
        return Job(
            id: id,
            title: title,
            company: company,
            location: location,
            salaryRange: salaryRange,
            description: description,
            companyInfo: companyInfo
        )
    }
}