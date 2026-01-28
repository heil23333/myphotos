//
//  Photo.swift
//  MyPhotos
//
//  Created by  He on 2026/1/28.
//

import SwiftUI
import SwiftData

@Model
class Photo: Identifiable, Hashable {
    var id = UUID()
    var name: String
    @Attribute(.externalStorage) var photo: Data
    
    init(id: UUID = UUID(), name: String, photo: Data) {
        self.id = id
        self.name = name
        self.photo = photo
    }
}
