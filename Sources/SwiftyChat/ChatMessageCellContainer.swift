//
//  MessageCell.swift
//  SwiftyChatbot
//
//  Created by Enes Karaosman on 18.05.2020.
//  Copyright © 2020 All rights reserved.
//

import SwiftUI

struct ChatMessageCellContainer<Message: ChatMessage>: View {
    @EnvironmentObject var style: ChatMessageCellStyle
    
    let message: Message
    let isSameUser: Bool
    let size: CGSize

    var usernameStyle: UsernameStyle {
        message.isSender ? style.outgoingUsernameStyle : style.incomingUsernameStyle
    }
    
    let onQuickReplyItemSelected: (QuickReplyItem) -> Void
    let contactFooterSection: (ContactItem, Message) -> [ContactCellButton]
    let onTextTappedCallback: () -> AttributedTextTappedCallback
    let onCarouselItemAction: (CarouselItemButton, Message) -> Void
    
    @ViewBuilder private func messageCell() -> some View {
        VStack(alignment: message.isSender ? .trailing : .leading) {
            if isSameUser && usernameStyle.showUsername {
                Text(message.user.userName)
                    .fontWeight(usernameStyle.textStyle.fontWeight)
                    .font(usernameStyle.textStyle.font)
                    .foregroundColor(usernameStyle.textStyle.textColor)
            }

            switch message.messageKind {

            case .text(let text):
                TextCell(
                    text: text,
                    message: message,
                    size: size,
                    callback: onTextTappedCallback
                )

            case .location(let location):
                LocationCell(
                    location: location,
                    message: message,
                    size: size
                )

            case .imageText(let imageLoadingType, let text):
                ImageTextCell(
                    message: message,
                    imageLoadingType: imageLoadingType,
                    text: text,
                    size: size
                )

            case .image(let imageLoadingType):
                ImageCell(
                    message: message,
                    imageLoadingType: imageLoadingType,
                    size: size
                )

            case .contact(let contact):
                ContactCell(
                    contact: contact,
                    message: message,
                    size: size,
                    footerSection: contactFooterSection
                )

            case .quickReply(let quickReplies):
                QuickReplyCell(
                    quickReplies: quickReplies,
                    quickReplySelected: onQuickReplyItemSelected
                )

            case .carousel(let carouselItems):
                CarouselCell(
                    carouselItems: carouselItems,
                    size: size,
                    message: message,
                    onCarouselItemAction: onCarouselItemAction
                )

            case .video(let videoItem):
                VideoPlaceholderCell(
                    media: videoItem,
                    message: message,
                    size: size
                )

            case .loading:
                LoadingCell(message: message, size: size)
            }
        }
    }
    
    var body: some View {
        messageCell()
    }
    
}
