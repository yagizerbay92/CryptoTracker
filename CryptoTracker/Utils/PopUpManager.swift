//
//  PopUpManager.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 17.05.2023.
//

import Foundation
import SwiftEntryKit
import UIKit

class PopUpManager {
    public static let shared = PopUpManager()
    private init() {}
    

    func showAlertView() {
        let title = EKProperty.LabelContent(text: "Opps!?",
                                            style: .init(font: .systemFont(ofSize: 12, weight: .bold),
                                                         color: .init(.systemRed),
                                                         alignment: .center))
        
        let text = "Something went wrong while updating the market list."
        let description = EKProperty.LabelContent(text: text,
                                                  style: .init(font: .systemFont(ofSize: 10, weight: .medium),
                                                               color: .black,
                                                               alignment: .center))
        let simpleMessage = EKSimpleMessage(
            title: title,
            description: description
        )
        
        let buttonFont: UIFont = .systemFont(ofSize: 16, weight: .medium)
        let closeButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont,
                                                          color: .init(.gray))
        let closeButtonLabel = EKProperty.LabelContent(text: "CLOSE",
                                                       style: closeButtonLabelStyle)
        let closeButton = EKProperty.ButtonContent(
            label: closeButtonLabel,
            backgroundColor: .clear,
            highlightedBackgroundColor: .init(.gray.withAlphaComponent(0.5))) {
                SwiftEntryKit.dismiss()
            }
        
        let buttonsBarContent = EKProperty.ButtonBarContent(
            with: closeButton,
            separatorColor: .init(.gray),
            expandAnimatedly: true
        )
        
        let alertMessage = EKAlertMessage(simpleMessage: simpleMessage,
                                          buttonBarContent: buttonsBarContent)
        
        
        var attributes = EKAttributes()
        attributes.position = .center
        attributes.entryBackground = .color(color: .init(.white))
        attributes.screenBackground = .visualEffect(style: .dark)
        attributes.displayDuration = .infinity
        
        let contentView = EKAlertMessageView(with: alertMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}
