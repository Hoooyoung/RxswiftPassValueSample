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
    var seModel: VGModel!
    var indxep: IndexPath!
    let disposeBag = DisposeBag()
   fileprivate var textF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .gray
    tf.addTarget(self, action: #selector(textChange(textF:)), for: .valueChanged)
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
        
        if let model = seModel {
            textF.text = model.title
            swit.isOn = model.isFinished
        }else{
            seModel = VGModel(title: "", isFinished: false)
        }
        
        
//        textF.rx.text.subscribe(onNext: { [weak self](text) in
//            self?.seModel.title = text ?? ""
//        })
//        .disposed(by: disposeBag)
        swit.rx.isOn.subscribe(onNext: { [weak self](isOn) in
//            self?.model.isFinished = isOn
        })
        .disposed(by: disposeBag)
    }
    
    @objc func textChange(textF: String) {
        self.seModel.title = textF
    }
    
    @objc func didDoneAciton() {
        pushSub.onNext((seModel, indxep))
        
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("销毁了")
    }
    
}

