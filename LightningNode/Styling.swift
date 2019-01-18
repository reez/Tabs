//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation
import UIKit

func baseButtonStyle(_ button: UIButton) {
    button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
}

let roundedStyle: (UIView) -> Void = {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 6
}

func borderStyle(color: UIColor, width: CGFloat) -> (UIView) -> Void {
    return {
        $0.layer.borderColor = color.cgColor
        $0.layer.borderWidth = width
    }
}

func backgroundStyle(color: UIColor) -> (UIView) -> Void {
    return {
        $0.backgroundColor = color
    }
}

let roundedButtonStyle =
    baseButtonStyle
        <> roundedStyle

let filledButtonStyle =
    roundedButtonStyle
        <> {
            $0.backgroundColor = .mr_black
            $0.tintColor = .white
            $0.setTitleColor(.white, for: .normal)
}

let borderButtonStyle  =
    roundedButtonStyle
        <> borderStyle(color: .mr_blue, width: 2)

let invoiceButtonStyle =
    filledButtonStyle
        <> { $0.backgroundColor = .mr_purple }

func fontStyle(ofSize size: CGFloat, weight: UIFont.Weight) -> (UILabel) -> Void {
    return {
        $0.font = .systemFont(ofSize: size, weight: weight)
    }
}

func fontStyle(_ myFont: UIFont) -> (UILabel) -> Void {
    return {
        $0.font = myFont
    }
}

func fontStyle(_ myFont: UIFont) -> (UITextField) -> Void {
    return {
        $0.font = myFont
    }
}

func textColorStyle(_ color: UIColor) -> (UILabel) -> Void {
    return {
        $0.textColor = color
    }
}

let baseLabelStyleSmallCaption: (UILabel) -> Void =
    fontStyle(UIFont.preferredFont(forTextStyle: .caption1).smallCaps)

//let baseLabelStyleSmallTitle: (UILabel) -> Void =
//    fontStyle(UIFont.preferredFont(forTextStyle: .body).smallCaps)

let baseLabelStyleBoldCaption: (UILabel) -> Void =
    fontStyle(UIFont.preferredFont(forTextStyle: .caption1).bolded)

let baseLabelStyleBoldTitle: (UILabel) -> Void =
    fontStyle(UIFont.preferredFont(forTextStyle: .title1).bolded)

let baseTextFieldStyleBold: (UITextField) -> Void =
    fontStyle(UIFont.preferredFont(forTextStyle: .body).bolded)

extension UIFont {
    public var smallCaps: UIFont {
        let upperCaseFeature = [
            UIFontDescriptor.FeatureKey.featureIdentifier : kUpperCaseType,
            UIFontDescriptor.FeatureKey.typeIdentifier : kUpperCaseSmallCapsSelector
        ]
        let lowerCaseFeature = [
            UIFontDescriptor.FeatureKey.featureIdentifier : kLowerCaseType,
            UIFontDescriptor.FeatureKey.typeIdentifier : kLowerCaseSmallCapsSelector
        ]
        let features = [upperCaseFeature, lowerCaseFeature]
        let smallCapsDescriptor = self.fontDescriptor.addingAttributes([UIFontDescriptor.AttributeName.featureSettings : features])
        return UIFont(descriptor: smallCapsDescriptor, size: 0)
    }
    
    public var largeCaps: UIFont {
        let upperCaseFeature = [
            UIFontDescriptor.FeatureKey.featureIdentifier : kUpperCaseType,
            UIFontDescriptor.FeatureKey.typeIdentifier :  kUpperAndLowerCaseSelector// kDefaultUpperCaseSelector, kUpperCasePetiteCapsSelector, kUpperCaseSmallCapsSelector
        ]
        let lowerCaseFeature = [
            UIFontDescriptor.FeatureKey.featureIdentifier : kLowerCaseType,
            UIFontDescriptor.FeatureKey.typeIdentifier : kLowerCaseSmallCapsSelector
        ]
        let features = [upperCaseFeature, lowerCaseFeature]
        let smallCapsDescriptor = self.fontDescriptor.addingAttributes([UIFontDescriptor.AttributeName.featureSettings : features])
        return UIFont(descriptor: smallCapsDescriptor, size: 0)
    }
    
    public var bolded: UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(.traitBold) else { return self }
        return UIFont(descriptor: descriptor, size: 0)
    }
}

extension UIColor {
    public static let mr_black = UIColor(white: 0.07, alpha: 1)
    public static let mr_blue = UIColor(red: 76/255, green: 204/255, blue: 255/255, alpha: 1)
    public static let mr_gray950 = UIColor(white: 0.95, alpha: 1.0)
    public static let mr_green = UIColor(red: 121/255, green: 242/255, blue: 176/255, alpha: 1)
    public static let mr_purple = UIColor(red: 151/255, green: 77/255, blue: 255/255, alpha: 1)
    public static let mr_red = UIColor(red: 235/255, green: 28/255, blue: 38/255, alpha: 1)
    public static let mr_yellow = UIColor(red: 255/255, green: 240/255, blue: 128/255, alpha: 1)
    public static let mr_gold = UIColor(red: 212/255, green: 175/255, blue: 55/255, alpha: 1)
}
