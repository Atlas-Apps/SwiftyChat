//
//  MessageCell.swift
//  SwiftyChatbot
//
//  Created by Enes Karaosman on 18.05.2020.
//  Copyright © 2020 All rights reserved.
//

import SwiftUI

public struct ChatMessageCellContainer: View {
    
    public let message: ChatMessage
    public let proxy: GeometryProxy
    
    public let onQuickReplyItemSelected: (QuickReplyItem) -> Void
    public let footerSection: (ContactItem, ChatMessage) -> [ContactCellButton]
    
    func messageCell() -> some View {
        switch message.messageKind {
            
        case .text(let text):
            
            return DefaultTextCell(
                text: text,
                message: message
            ).embedInAnyView()
            
        case .location(let location):
            
            return DefaultLocationCell(
                location: location,
                message: message,
                proxy: proxy
            ).embedInAnyView()
            
        case .image(let imageLoadingType):
            
            return DefaultImageCell(
                message: message,
                imageLoadingType: imageLoadingType,
                proxy: proxy
            ).embedInAnyView()
            
        case .contact(let contact):
            
            return DefaultContactCell(
                contact: contact,
                message: message,
                proxy: proxy,
                footerSection: footerSection
            ).embedInAnyView()
            
        case .quickReply(let quickReplies):
            return QuickReplyCell(
                quickReplies: quickReplies,
                quickReplySelected: onQuickReplyItemSelected
            ).embedInAnyView()
            
        }
    }
    
    public var body: some View {
        messageCell()
    }
    
}
