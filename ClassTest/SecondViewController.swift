//
//  SecondViewController.swift
//  ClassTest
//
//  Created by Stefan on 2021/3/30.
//

import UIKit
import RxSwift
import RxCocoa

class SecondViewController: UIViewController {
    fileprivate let pushSub = PublishSubject<(VGModel, IndexPath)>()
    var todoOB: Observable<(VGModel, IndexPath)> {
        return pushSub.asObservable()
    }
    var model: VGModel!
    var indxep: IndexPath!
    let disposeBag = DisposeBag()
   fileprivate var textF: UITextField = {
        let tf = UITextField()
    tf.backgroundColor = .gray
        return tf
    }()
    fileprivate var swit: UISwitch = {
       let swithc = UISwitch()
        return swithc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        self.view.addSubview(textF)
        self.view.addSubview(swit)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didDoneAciton))
        
        textF.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(100)
        }
        
        swit.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(200)
            make.right.equalTo(self.view).offset(-30)
        }
        
        if let model = model {
            textF.text = model.title
            swit.isOn = model.isFinished
        }else{
            model = VGModel(title: "", isFinished: false)
        }
        
        textF.rx.text.subscribe(onNext: { (text) in
            self.model.title = text ?? ""
        })
        .disposed(by: disposeBag)
        swit.rx.isOn.subscribe(onNext: { (isOn) in
            self.model.isFinished = isOn
        })
        .disposed(by: disposeBag)
    }
    
    @objc func didDoneAciton() {
        pushSub.onNext((model, indxep))
        self.navigationController?.popViewController(animated: true)
    }
}
