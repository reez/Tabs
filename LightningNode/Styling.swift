//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox

func autolayoutStyle(_ view: UIView) -> Void {
    view.translatesAutoresizingMaskIntoConstraints = false
}

let baseLayoutMargins: (UIView) -> Void = {
    $0.layoutMargins = UIEdgeInsets(top: .mr_grid(12), left: .mr_grid(6), bottom: .mr_grid(6), right: .mr_grid(6))
}

let invoiceLayoutMargins: (UIView) -> Void = {
    $0.layoutMargins = UIEdgeInsets(top: .mr_grid(6), left: .mr_grid(6), bottom: .mr_grid(6), right: .mr_grid(6))
}

let invoiceSmallLayoutMargins: (UIView) -> Void = {
    $0.layoutMargins = UIEdgeInsets(top: .mr_grid(2), left: .mr_grid(2), bottom: .mr_grid(2), right: .mr_grid(2))
}

let statusRootStackViewStyle: (UIStackView) -> Void =
    autolayoutStyle
        <> {
            $0.axis = .vertical
            $0.isLayoutMarginsRelativeArrangement = true
            $0.spacing = .mr_grid(32)
}

let invoiceRootStackViewStyle: (UIStackView) -> Void =
    autolayoutStyle
        <> {
            $0.axis = .vertical
            $0.isLayoutMarginsRelativeArrangement = true
            $0.spacing = .mr_grid(12)
}

let rootStackViewStyle: (UIStackView) -> Void =
    autolayoutStyle
        <> {
            $0.isLayoutMarginsRelativeArrangement = true
            $0.spacing = .mr_grid(6)
}

let centerStyle: (UILabel) -> Void = {
    $0.textAlignment = .center
}

let smallCapsText: (UILabel) -> Void = {
    $0.font = UIFont.preferredFont(forTextStyle: .caption1).smallCaps
}

let title3Text: (UILabel) -> Void = {
    $0.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
}

let baseTextStyle: (UILabel) -> Void = {
    $0.numberOfLines = 0
}

let finePrintStyle: (UILabel) -> Void =
    centerStyle
        <> baseTextStyle
        <> { $0.font = UIFont.preferredFont(forTextStyle: .largeTitle)}

let checkboxStyle: (M13Checkbox) -> Void = {
    $0.animationDuration = 0.50
    $0.setCheckState(.unchecked, animated: true)
    $0.tintColor = .mr_green
    $0.secondaryTintColor = .mr_gray
    $0.checkmarkLineWidth = 6.0
    $0.boxLineWidth = 3.0
    $0.boxType = .circle
}

let nameStyle: (UILabel) -> Void = {
    $0.textColor = .mr_black
    $0.font = UIFont.preferredFont(forTextStyle: .caption1).smallCaps
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.numberOfLines = 0
}

let textFieldStyle: (UITextField) -> Void = {
    $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
    $0.borderStyle = .roundedRect
}

let baseButtonStyle: (UIButton) -> Void = {
    $0.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
}

let roundedStyle: (UIView) -> Void = {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 6
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

let unfilledButtonStyle =
    roundedButtonStyle
        <> {
            $0.backgroundColor = .white
            $0.tintColor = .white
            $0.setTitleColor(.mr_gold, for: .normal)
}

let removeButtonStyle =
    roundedButtonStyle
        <> {
            $0.backgroundColor = .white
            $0.tintColor = .white
            $0.setTitleColor(.mr_red, for: .normal)
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

let baseLabelStyleTitle: (UILabel) -> Void =
    fontStyle(UIFont.preferredFont(forTextStyle: .title3))

let baseLabelStyleSubheadline: (UILabel) -> Void =
    fontStyle(UIFont.preferredFont(forTextStyle: .subheadline))

let baseLabelStyleSmallCaption: (UILabel) -> Void =
    fontStyle(UIFont.preferredFont(forTextStyle: .caption1).smallCaps)

let baseLabelStyleBoldTitle: (UILabel) -> Void =
    fontStyle(UIFont.preferredFont(forTextStyle: .title1).bolded)

let baseTextFieldStyleBoldBody: (UITextField) -> Void =
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
    public static let mr_blue = UIColor(red: 0/255, green: 172/255, blue: 255/255, alpha: 1)
    public static let mr_gray = UIColor(white: 0.95, alpha: 1.0)
    public static let mr_green = UIColor(red: 121/255, green: 242/255, blue: 176/255, alpha: 1)
    public static let mr_purple = UIColor(red: 151/255, green: 77/255, blue: 255/255, alpha: 1)
    public static let mr_red = UIColor(red: 235/255, green: 28/255, blue: 38/255, alpha: 1)
    public static let mr_yellow = UIColor(red: 255/255, green: 240/255, blue: 128/255, alpha: 1)
    public static let mr_gold = UIColor(red: 212/255, green: 175/255, blue: 55/255, alpha: 1)
}

extension CGFloat {
    static func mr_grid(_ n: Int) -> CGFloat {
        return CGFloat(n) * 4
    }
}

public var mrDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE MMM d, yyyy h:mm:ss a"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"
    return formatter
}
