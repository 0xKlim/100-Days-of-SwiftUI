//
//  ContentView.swift
//  13_Instafilter
//
//  Created by Vladislav on 28.05.2026.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var loadedImage: CIImage?
    @State private var processedImage: Image?
    @State private var showingFilters = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 100.0
    @State private var filterScale = 5.0
    
    @State private var context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem){
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                VStack {
                    let inputKeys = currentFilter.inputKeys
                    
                    FilterSliderView("Intensity", value: $filterIntensity, in: 0...1)
                        .disabled(!inputKeys.contains(kCIInputIntensityKey))
                        .onChange(of: filterIntensity, applyProcessing)
                    
                    FilterSliderView("Radius", value: $filterRadius, in: 0...200)
                        .disabled(!inputKeys.contains(kCIInputRadiusKey))
                        .onChange(of: filterRadius, applyProcessing)
                    
                    FilterSliderView("Scale", value: $filterScale, in: 0...100)
                        .disabled(!inputKeys.contains(kCIInputScaleKey))
                        .onChange(of: filterScale, applyProcessing)
                }
                .disabled(processedImage == nil)
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter", action: changeFilter)
                    
                    Spacer()
                    
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Bloom") { setFilter(CIFilter.bloom()) }
                Button("Gloom") { setFilter(CIFilter.gloom()) }
                Button("Dither") { setFilter(CIFilter.dither()) }
            }
        }
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        setupFilter()
        
        filterCount += 1
        if filterCount >= 20 {
            requestReview()
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try? await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            loadedImage = beginImage
            setupFilter()
        }
    }
    
    func setupFilter() {
        guard let loadedImage else { return }
        
        currentFilter.setValue(loadedImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
