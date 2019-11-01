import UIKit

public protocol SUView: UIView {
    func configure(_ f: (Self) -> Void) -> Self
}

extension SUView {
    public func configure(_ f: (Self) -> Void) -> Self {
        f(self)
        return self
    }
}

public class SUBaseView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        if let v = build() {
            setContentView(v)
        }
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func build() -> UIView? { nil }
}

public final class PlainView: UIView, SUView {
}

public final class Spacer: UIView, SUView {
    public init() {
        super.init(frame: .zero)
        
        setContentHuggingPriority(UILayoutPriority(0), for: .vertical)
        setContentHuggingPriority(UILayoutPriority(0), for: .horizontal)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

public final class LabelView: UILabel, SUView {
    public func outlet<O>(_ owner: O, _ keyPath: ReferenceWritableKeyPath<O, LabelView?>) -> LabelView {
        owner[keyPath: keyPath] = self
        
        return self
    }
}

public final class StackView: UIStackView, SUView {
    public init(axis: NSLayoutConstraint.Axis,
                @SUViewBuilder builder: () -> [UIView])
    {
        super.init(frame: .zero)
    
        self.axis = axis
        self.isLayoutMarginsRelativeArrangement = true
        self.insetsLayoutMarginsFromSafeArea = true
        
        for v in builder() {
            addArrangedSubview(v)
        }
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
