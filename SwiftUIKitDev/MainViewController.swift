import UIKit

class MainViewController: UIViewController {
    private var contentView: MainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView = MainView().configure { v in
            v.text1 = "Hello"
            v.text2 = "SwiftUIKit"
        }
        view.setContentView(contentView)
    }
}

public final class MainView: SUBaseView, SUView {
    private var label1: LabelView!
    private var label2: LabelView!
    
    public var text1: String? {
        get { label1.text }
        set { label1.text = newValue }
    }
    
    public var text2: String? {
        get { label2.text }
        set { label2.text = newValue }
    }
    
    public override func build() -> UIView? {
        StackView(axis: .vertical) {
            LabelView().outlet(self, \.label1)
            LabelView().outlet(self, \.label2).configure { v in
                v.textColor = UIColor.blue
            }
            Spacer()
        }
    }
    
}
