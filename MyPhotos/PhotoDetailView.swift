//
//  PhotoDetailView.swift
//  MyPhotos
//
//  Created by  He on 2026/1/28.
//

import SwiftUI
import MapKit

struct PhotoDetailView: View {
    var photo: Photo
    @State var showImage = true
    
    var body: some View {
        Group {
            if showImage {
                if let uiImage = UIImage(data: photo.photo) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    ContentUnavailableView("照片显示错误", systemImage: "photo", description: Text(""))
                }
            } else {
                if let latitude = photo.latitude, let longitude = photo.longitude {
                    Map {
                        Marker(photo.name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                    }
                } else {
                    ContentUnavailableView("位置信息缺失", systemImage: "map", description: Text(""))
                }
            }
        }
        .navigationTitle(photo.name)
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            if photo.hasLocation {
                ToolbarItem(placement: .confirmationAction) {
                    Button(showImage ? "查看位置": "显示照片") {
                        showImage.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    let sampleImage = UIImage(systemName: "photo")!
    let sampleData = sampleImage.jpegData(compressionQuality: 1.0)!
    let samplePhoto = Photo(name: "示例照片", photo: sampleData, latitude: 0.0, longitude: 0.0)
    
    PhotoDetailView(photo: samplePhoto)
}
