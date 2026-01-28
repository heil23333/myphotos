//
//  MyPhotosApp.swift
//  MyPhotos
//
//  Created by  He on 2026/1/28.
//

import SwiftUI
import SwiftData

@main
struct MyPhotosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Photo.self)
    }
}
