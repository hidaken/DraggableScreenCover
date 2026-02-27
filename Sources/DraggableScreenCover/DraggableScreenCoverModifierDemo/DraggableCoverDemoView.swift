//
//  DraggableCoverDemo.swift
//  ShadowingMaster
//
//  Created by hidaken on 2026/02/23.
//
import SwiftUI

private struct DraggableCoverDemoView: View {
    @State private var showDraggableCover = false
    @State private var showDraggableCoverWithID = false
    @State private var showFullScreenCover = false
    @State private var showNormalCover = false
    
    let sourceId: String = UUID().uuidString
    @Namespace var namespace
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            VStack {
                button("SHOW DRAGGABLE COVER") {
                    showDraggableCover = true
                }
                
                button("SHOW DRAGGABLE COVER WITH ID") {
                    showDraggableCoverWithID = true
                }
                
                button("SHOW FULL SCREEN COVER") {
                    showFullScreenCover = true
                }
                
                button("SHOW NORMAL SHEET COVER") {
                    showNormalCover = true
                }
            }
            
            Spacer()
            
            Capsule(style: .continuous)
                .frame(width: 300, height: 68)
                .foregroundStyle(.red)
                .matchedTransitionSource(id: sourceId, in: namespace)
                .onTapGesture {
                    showDraggableCoverWithID = true
                }

            
        }
        .draggableScreenCover(
            isPresented: $showDraggableCover,
//            backgroundColor: .red
        ) {
            DemoCoverView()
        }
        .draggableScreenCover(
            isPresented: $showDraggableCoverWithID,
//            backgroundColor: .red,
            sourceId: sourceId, in: namespace
        ) {
            DemoCoverView()
        }
        .fullScreenCover(isPresented: $showFullScreenCover) {
            DemoCoverView()
        }
        .sheet(isPresented: $showNormalCover) {
            DemoCoverView()
        }
    }
    
    func button(_ text: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(text)
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .padding(.horizontal)
    }
}

private struct DemoCoverView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("Cover")
                .font(.largeTitle.bold())
            
            Button {
                dismiss()
            } label: {
                Text("CLOSE")
            }
            
            Spacer()
        }
    }
}

#Preview("DraggableCoverDemo") {
    DraggableCoverDemoView()
}
