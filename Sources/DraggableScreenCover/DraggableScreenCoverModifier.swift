//
//  DraggableScreenCoverModifier.swift
//  ShadowingMaster
//
//  Created by hidaken on 2026/02/23.
//
import SwiftUI

public extension View {
    func draggableScreenCover<Cover: View, ID: Hashable>(
        isPresented: Binding<Bool>,
        backgroundColor: Color = Color(uiColor: UIColor.systemBackground),
        sourceId: ID, in namespace: Namespace.ID,
        @ViewBuilder content: @escaping () -> Cover
    ) -> some View {
        modifier(
            DraggableScreenCoverModifier(
                isPresented: isPresented,
                backgroundColor: backgroundColor,
                sourceId: sourceId, namespace: namespace,
                content: content
            )
        )
    }
    
    func draggableScreenCover<Cover: View>(
        isPresented: Binding<Bool>,
        backgroundColor: Color = Color(uiColor: UIColor.systemBackground),
        @ViewBuilder content: @escaping () -> Cover
    ) -> some View {
        modifier(
            DraggableScreenCoverModifier(
                isPresented: isPresented,
                backgroundColor: backgroundColor,
                sourceId: Optional<AnyHashable>.none, namespace: nil,
                content: content
            )
        )
    }
}

private struct DraggableScreenCoverModifier<Cover: View, ID: Hashable>: ViewModifier {

    @Binding var isPresented: Bool
    
    let backgroundColor: Color
    
    let sourceId: ID?
    let namespace: Namespace.ID?
    
    @ViewBuilder let content: () -> Cover
    
    private let subSourceId = UUID().uuidString
    @Namespace private var subNamespace
    
    func body(content presenter: Content) -> some View {
        if let sourceId, let namespace {
            NavigationStack {
                presenter
                    .navigationDestination(isPresented: $isPresented) {
                        contentWrapper
                            .navigationTransition(.zoom(sourceID: sourceId, in: namespace))
                            .navigationBarBackButtonHidden()
                    }
            }
        } else {
            NavigationStack {
                ZStack(alignment: .bottom) {
                    presenter
                    
                    Rectangle()
                        .fill(.white.opacity(0.0001))
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .matchedTransitionSource(id: subSourceId, in: subNamespace)
                }
                .navigationDestination(isPresented: $isPresented) {
                    contentWrapper
                        .navigationTransition(.zoom(sourceID: subSourceId, in: subNamespace))
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
    
    private var contentWrapper: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack {
                headerDragHandle
                content()
            }
        }
    }
    
    private var headerDragHandle: some View {
        VStack(spacing: 8) {
            if #available(iOS 26.0, *) {
                Capsule()
                    .fill(.secondary.opacity(0.6))
                    .frame(width: 60, height: 5)
                    .glassEffect(.regular.interactive())
            } else {
                Capsule()
                    .fill(.secondary.opacity(0.6))
                    .frame(width: 60, height: 5)
                    .background(.thinMaterial)
            }
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle()) // for draggable
        .padding(.top, 6)
        .padding(.bottom, 8)
        .onTapGesture {
            isPresented = false
        }
    }
}
