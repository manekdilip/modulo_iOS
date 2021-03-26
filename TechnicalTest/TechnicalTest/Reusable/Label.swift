import UIKit

class Label: UILabel {
    
    enum LabelType {
        case normal
        case value1
        case counter
        case date
        case subtitle
        case activeSubtitle
        case button
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ text: String = "", type: LabelType = .normal, color: UIColor = .black) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = color
        translatesAutoresizingMaskIntoConstraints = false
        
        var pointSize: CGFloat {
            switch type {
            case .subtitle, .activeSubtitle, .date:
                return UIFontDescriptor.preferredFontDescriptor(withTextStyle: .footnote).pointSize
            case .button:
                return UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title2).pointSize
            default:
                return UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).pointSize
            }
        }
       // font = UIFont(name: font.fontName, size: pointSize)
        font = UIFont.systemFont(ofSize: pointSize)
        
        switch type {
        case .value1:
            isEnabled = false
            textAlignment = .right
            numberOfLines = 0
        case .counter:
            textAlignment = .right
            isEnabled = false
        case .date:
            numberOfLines = 2
            isEnabled = false
            textAlignment = .right
        case .subtitle:
            numberOfLines = 0
            isEnabled = false
        case .activeSubtitle:
            numberOfLines = 2
        default:
            return
        }        
    }
    
    func set(value: String?, color: UIColor? = nil) {
        text = value
        if color != nil {
            textColor = color
        }
    }
}
