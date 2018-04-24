//
//  SeedDataHomeOptions.swift
//  EventApp
//
//  Created by Fernando on 24.04.18.
//  Copyright © 2018 Fernando. All rights reserved.
//

import Foundation


struct SeedData {
    
    static let homeOptions = [
        HomeOption(imageURL: "clock", text: "Programm"),
        HomeOption(imageURL: "map", text: "Map of Site"),
        HomeOption(imageURL: "exhibit", text: "Exhibits"),
        HomeOption(imageURL: "selfie", text: "Selfie"),
        HomeOption(imageURL: "visit", text: "My Visit"),
        HomeOption(imageURL: "media", text: "Media")
    ]
    
}

struct HomeOption {
    var imageURL: String
    var text: String
}
