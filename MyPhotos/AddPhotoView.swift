//
//  AddPhotoView.swift
//  MyPhotos
//
//  Created by  He on 2026/1/28.
//

import SwiftUI
import PhotosUI
import SwiftData

struct AddPhotoView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State var pickerItem: PhotosPickerItem?
    @State var selectedImage: Image?
    @State var selectedImageData: Data?
    @State var photoName: String = ""
    var disabled: Bool {
        photoName.isEmpty || selectedImageData == nil
    }
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $pickerItem) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.1))
                            .padding(.horizontal)
                        
                        if let selectedImage {
                            selectedImage
                                .resizable()
                                .scaledToFit()
                        } else {
                            ContentUnavailableView("未选择图片", systemImage: "photo.badge.plus", description: Text("点击导入图片"))
                        }
                    }
                }
                .frame(height: 250)
                .buttonStyle(.plain)
                .onChange(of: pickerItem, loadImage)
                
                TextField("输入照片名称", text: $photoName)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray.opacity(0.6), lineWidth: 1))
                    .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("添加照片")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        if let location = locationFetcher.lastKnowLocation, let selectedImageData {
                            let photo = Photo(name: photoName, photo: selectedImageData, latitude: location.latitude, longitude: location.longitude)
                            modelContext.insert(photo)
                        }
                        
                        dismiss()
                    }
                    .disabled(disabled)
                }
            }
        }
        .onAppear() {
            locationFetcher.start()
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await pickerItem?.loadTransferable(type: Data.self) else {
                return
            }
            selectedImageData = imageData
            if let uiImage = UIImage(data: imageData) {
                selectedImage = Image(uiImage: uiImage)
            }
            
        }
    }
}

#Preview {
    AddPhotoView()
}
