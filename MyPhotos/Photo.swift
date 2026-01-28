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
    
    var latitude: Double?
    var longitude: Double?
    
    var hasLocation: Bool { latitude != nil && longitude != nil }
    
    init(id: UUID = UUID(), name: String, photo: Data, latitude: Double?, longitude: Double?) {
        self.id = id
        self.name = name
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
    }
}
