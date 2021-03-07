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
    
    // getting started
    let coachMarksController = CoachMarksController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.coachMarksController.dataSource = self
    }
}
//MARK: - viewController extension
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
 
    // 몇개의 뷰에 대해 가이드를 제공할 것인가.
    
}

extension ViewController : CoachMarksControllerDelegate {
    
}

