// Photos are from https://unsplash.com

import SwiftUI

struct PhotosView: View {
    @State private var detail: Int? = nil
    @State private var slowAnimations = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            Toggle("Slow Animations", isOn: $slowAnimations)
            ZStack {
                photoGrid
                    .opacity(detail == nil ? 1 : 0)
                detailView
            }
            .animation(.default.speed(slowAnimations ? 0.2 : 1), value: detail)
        }
    }
    
    @ViewBuilder
    var detailView: some View {
        if let d = detail {
            Image("beach_\(d)")
                .resizable()
                .matchedGeometryEffect(id: d, in: namespace, isSource: false)
                .aspectRatio(contentMode: .fit)
                .onTapGesture {
                    detail = nil
                }
        }
    }
    
    var photoGrid: some View {
        ScrollView {
            LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: .infinity), spacing: 3)], spacing: 3) {
                ForEach(1..<11) { ix in
                    Image("beach_\(ix)")
                        .resizable()
                        .matchedGeometryEffect(id: ix, in: namespace)
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .clipped()
                        .aspectRatio(1, contentMode: .fit)
                        .onTapGesture {
                            detail = ix
                        }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        PhotosView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
