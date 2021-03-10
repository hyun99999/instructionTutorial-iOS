//
//  ViewController.swift
//  instructionTutorial-iOS
//
//  Created by kimhyungyu on 2021/03/07.
//

import UIKit
import Instructions

class ViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var subscribeBtn: UIButton!
    @IBOutlet weak var alartmBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    
    // 'instructions'getting started
    let coachMarksController = CoachMarksController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 데이터 소스를 통해 보여줄 뷰를 지정
        self.coachMarksController.dataSource = self
        // 델리겟 설정
        self.coachMarksController.delegate = self
        // overlay tappable(A tap on the overlay will hide the current coach mark and display the next one.)
        self.coachMarksController.overlay.isUserInteractionEnabled = true
        
        //animation delegate
        self.coachMarksController.animationDelegate = self
        
        //스킵할 수 있는 뷰를 지정
        let skipView = CoachMarkSkipDefaultView()
        skipView.setTitle("튜토리얼 스킵하기", for: .normal)
        self.coachMarksController.skipView = skipView
        
        //튜토리얼 중에 status바 없애기
        self.coachMarksController.statusBarVisibility = .hidden
    }
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        self.coachMarksController.start(in: .window(over: self))
    }
    // 뷰가 사라질 때 흐름 종료.
    // To avoid animation artefacts and timing issues
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.coachMarksController.stop(immediately: true)
    }
}
//MARK: - CoachMarksControllerDataSource
// 보여줄 뷰를 설정
extension ViewController : CoachMarksControllerDataSource {
    // 가이드 마커에 대한 설정(테이블뷰의 셀 설정과 비슷)
    // supplies two views. body view is mandatory, arrow view is optional
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        switch index {
        case 0:
            coachViews.bodyView.hintLabel.text = "이것은 당신의 프사입니다."
            coachViews.bodyView.nextLabel.text = "다음!"
            coachViews.bodyView.background.innerColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            coachViews.arrowView?.background.innerColor =  #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            coachViews.bodyView.background.borderColor = .yellow
            coachViews.bodyView.hintLabel.textColor = .white
            coachViews.bodyView.nextLabel.textColor = .yellow
        case 1:
            coachViews.bodyView.hintLabel.text = "이것은 당신의 닉네임입니다."
            coachViews.bodyView.nextLabel.text = "다음!"
        case 2:
            coachViews.bodyView.hintLabel.text = "이것은 구독 버튼입니다."
            coachViews.bodyView.nextLabel.text = "다음!"
        case 3:
            coachViews.bodyView.hintLabel.text = "이것은 좋아요 버튼입니다."
            coachViews.bodyView.nextLabel.text = "다음!"
        case 4:
            coachViews.bodyView.hintLabel.text = "이것은 알람설정 버튼입니다."
            coachViews.bodyView.nextLabel.text = "다음!"
        default:
            coachViews.bodyView.hintLabel.text = "이것은 당신의 프사입니다."
            coachViews.bodyView.nextLabel.text = "다음!"
        }
        //coachviews 와 arrowview 반환
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
        
        //5가지의 가이드 할 뷰에 대한 coachView 설정
    }
    // 몇개의 뷰에 대해 가이드를 제공할 것인가.
    // the number of coach marks to display.
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 5
    }
    
    // 가이드 할 뷰를 지정
    //asks for metadata.
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        switch index {
        case 0:
            return coachMarksController.helper.makeCoachMark(for: profileImg)
        case 1:
            return coachMarksController.helper.makeCoachMark(for: profileLabel)
        case 2:
            return coachMarksController.helper.makeCoachMark(for: subscribeBtn)
        case 3:
            return coachMarksController.helper.makeCoachMark(for: likeBtn)
        case 4:
            return coachMarksController.helper.makeCoachMark(for: alartmBtn)
        default:
            return coachMarksController.helper.makeCoachMark(for: profileImg)
        }
    }
}

//MARK: - CoachMarksControllerDelegate
extension ViewController : CoachMarksControllerDelegate {
    //customizing ornaments(장식품) of the overlay(뒤에 넣을 수 있는 뷰).
    func coachMarksController(_ coachMarksController: CoachMarksController, configureOrnamentsOfOverlay overlay: UIView) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        overlay.addSubview(label)
        
        label.text = "오버레이 입니다."
        label.alpha = 0.5
        label.font = label.font.withSize(60)
        
        label.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: overlay.topAnchor,constant: 100).isActive = true
    }
    //Using a delegate basic optional three things
    // coach mark will show. when you want to change something about the view.
    func coachMarksController(_ coachMarksController: CoachMarksController, willShow coachMark: inout CoachMark, beforeChanging change: ConfigurationChange, at index: Int) {
        print("willShow: index:\(index)")
    }
    // coach mark disappears
    func coachMarksController(_ coachMarksController: CoachMarksController, willHide coachMark: CoachMark, at index: Int) {
        print("willHide() index: \(index)")
    }
    //Whether to skip
    func coachMarksController(_ coachMarksController: CoachMarksController, didEndShowingBySkipping skipped: Bool) {
        print("스킵여부: ",skipped)
    }
}

//MARK: - CoachMarksControllerAnimationDelegate

extension ViewController: CoachMarksControllerAnimationDelegate {
    //마커가 나타날때
    func coachMarksController(_ coachMarksController: CoachMarksController, fetchAppearanceTransitionOfCoachMark coachMarkView: UIView, at index: Int, using manager: CoachMarkTransitionManager) {
        manager.parameters.options = [.beginFromCurrentState]
        manager.animate(.regular) { (CoachMarkAnimationManagementContext) in
            coachMarkView.transform = .identity
            coachMarkView.alpha = 1
        } fromInitialState: {
            coachMarkView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            coachMarkView.alpha = 0
        } completion: { (Bool) in
        }
    }
    //마커가 사라질때
    func coachMarksController(
        _ coachMarksController: CoachMarksController,
        fetchDisappearanceTransitionOfCoachMark coachMarkView: UIView,
        at index: Int,
        using manager: CoachMarkTransitionManager
    ) {
        manager.animate(.keyframe) { (CoachMarkAnimationManagementContext) in
            // 크기를 절반크기로 줄어들게 함
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1){
                coachMarkView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }
            // 줄어든 후 0.5 크기가 되었을 때 투명하게
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                coachMarkView.alpha = 0
            }
        }
    }
    //마커가 떠있을때
    func coachMarksController(
        _ coachMarksController: CoachMarksController,
        fetchIdleAnimationOfCoachMark coachMarkView: UIView,
        at index: Int,
        using manager: CoachMarkAnimationManager
    ) {
        
    }
}

