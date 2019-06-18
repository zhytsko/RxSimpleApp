import UIKit
import RxSwift

class ViewController: UIViewController {
    
    var circleView: UIView!
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCircleView()
    }
    
    func setupCircleView() {
        let frame = CGRect(origin: view.center, size: CGSize(width: 150, height: 150))
        circleView = UIView(frame: frame)
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = viewModel.getRandomColor()
        view.addSubview(circleView)
        
        circleView
            .rx.observe(CGPoint.self, "center")
            .bind(to: viewModel.circleCenterVariable)
            .disposed(by: disposeBag)
        
        viewModel.backgroundColorObservable
            .subscribe(onNext:{ [weak self] backgroundColor in
                UIView.animate(withDuration: 0.0) {
                    self?.view.backgroundColor = backgroundColor
                }
            })
            .disposed(by: disposeBag)
        
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
        UIView.animate(withDuration: 0.0) {
            self.circleView.backgroundColor = self.viewModel.getRandomColor()
        }
    }
}
