//
//  PhotoDetailView.swift
//  MyPhotos
//
//  Created by  He on 2026/1/28.
//

import SwiftUI

struct PhotoDetailView: View {
    var photo: Photo
    
    var body: some View {
        Group {
            if let uiImage = UIImage(data: photo.photo) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                ContentUnavailableView("照片显示错误", systemImage: "photo", description: Text(""))
            }
        }
        .navigationTitle(photo.name)
        .toolbarTitleDisplayMode(.inline)
    }
}

#Preview {
    let sampleImage = UIImage(systemName: "photo")!
    let sampleData = sampleImage.jpegData(compressionQuality: 1.0)!
    let samplePhoto = Photo(name: "示例照片", photo: sampleData)
    
    PhotoDetailView(photo: samplePhoto)
}
