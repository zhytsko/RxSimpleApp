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
        let motionGesture = UILongPressGestureRecognizer(target: self, action: #selector(circleMoved))
        let colorGesture = UITapGestureRecognizer(target: self, action: #selector(circlePainted))
        circleView.addGestureRecognizer(motionGesture)
        circleView.addGestureRecognizer(colorGesture)
    }
    
    @objc func circleMoved(recognizer: UILongPressGestureRecognizer) {
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.0) {
            self.circleView.center = location
        }
    }
    
    @objc func circlePainted(recognizer: UITapGestureRecognizer) {
        let red = CGFloat(Double.random(in: 0..<255) / 255.0)
        let green = CGFloat(Double.random(in: 0..<255) / 255.0)
        let blue = CGFloat(Double.random(in: 0..<255) / 255.0)
        UIView.animate(withDuration: 0.0) {
           self.circleView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
    }
}
