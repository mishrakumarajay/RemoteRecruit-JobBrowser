//
//  UIState.swift
//  RemoteRecruit
//
//  Created by Ajay Mishra on 18/06/2026.
//


import Foundation

public enum UIState<T: Equatable>: Equatable {
    case idle
    case loading
    case success(T)
    case empty
    case failure(String)
}