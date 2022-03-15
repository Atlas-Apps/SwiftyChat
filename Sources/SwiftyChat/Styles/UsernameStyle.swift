//
//  UsernameStyle.swift
//  
//
//  Created by Austin Evans on 3/15/22.
//

import SwiftUI

public struct UsernameStyle {
    public let showUsername: Bool
    public let textStyle: CommonTextStyle

    public init(showUsername: Bool, textStyle: CommonTextStyle) {
        self.showUsername = showUsername
        self.textStyle = textStyle
    }
}
