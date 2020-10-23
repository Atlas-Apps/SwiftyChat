//
//  View++.swift
//  SwiftyChatbot
//
//  Created by Enes Karaosman on 19.05.2020.
//  Copyright © 2020 All rights reserved.
//

import SwiftUI

public func conditionalStack<Content: View>(isVStack: Bool, content: () -> Content) -> AnyView {
    if isVStack {
        return VStack(alignment: .leading, spacing: 8) { content() }.embedInAnyView()
    }
    return HStack(spacing: 8) { content() }.embedInAnyView()
}

public extension View {
    
    @inlinable
    func then(_ body: (inout Self) -> Void) -> Self {
        var result = self
        body(&result)
        return result
    }
    
    @inlinable
    func embedInAnyView() -> AnyView {
        AnyView(self)
    }
    
    #if os(iOS)    
    func keyboardAwarePadding() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAwareModifier())
    }
    #endif
    
    @ViewBuilder func conditionalModifier<M1: ViewModifier, M2: ViewModifier>
        (on condition: Bool, trueCase: M1, falseCase: M2) -> some View {
        if condition {
            self.modifier(trueCase)
        } else {
            self.modifier(falseCase)
        }
    }
    
    @ViewBuilder func conditionalModifier<M: ViewModifier>
        (on condition: Bool, trueCase: M) -> some View {
        if condition {
            self.modifier(trueCase)
        }
    }
    
}
