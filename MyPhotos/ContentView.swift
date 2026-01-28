//
//  ContentView.swift
//  MyPhotos
//
//  Created by  He on 2026/1/28.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor<Photo>(\.name)]) var photos: [Photo]
    @State var showingAddPhoto: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if photos.isEmpty {
                    ContentUnavailableView("暂无照片", systemImage: "photo", description: Text("点击右上角添加"))
                } else {
                    List(photos) { photo in
                        NavigationLink(value: photo) {
                            HStack {
                                Group {
                                    if let uiImage = UIImage(data: photo.photo) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 8))
                                            .padding()
                                    } else {
                                        ContentUnavailableView("图片显示错误", systemImage: "photo", description: Text(""))
                                    }
                                }
                                .frame(width: 50, height: 50)
                                
                                Text(photo.name)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Photo.self, destination: { photo in
                PhotoDetailView(photo: photo)
            })
            .sheet(isPresented: $showingAddPhoto, content: {
                AddPhotoView()
            })
                .navigationTitle("我的相册")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("添加", systemImage: "plus") {
                            showingAddPhoto = true
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
