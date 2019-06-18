import UIKit

class ViewController: UIViewController {
    
    var circleView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCircle()
    }
    
    func setupCircle() {
        let frame = CGRect(origin: view.center, size: CGSize(width: 150, height: 150))
        circleView = UIView(frame: frame)
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = .red
        view.addSubview(circleView)
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved))
        circleView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func circleMoved(recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.0) {
            self.circleView.center = location
        }
    }
}
