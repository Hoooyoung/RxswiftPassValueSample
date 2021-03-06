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
    var stringH = ""
    var siwthcH = false
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
        
        textF.rx.text.subscribe(onNext: { [weak self](text) in
            self?.stringH = text ?? ""
        })
        .disposed(by: disposeBag)
        swit.rx.isOn.subscribe(onNext: { [weak self](isOn) in
            self?.siwthcH = isOn
        })
        .disposed(by: disposeBag)
    }
    
    @objc func didDoneAciton() {
        seModel.title = stringH
        seModel.isFinished = siwthcH
        pushSub.onNext((seModel, indxep))
        
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("?????????")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2 will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("2 did appear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("2 will disappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("2 did disappear")
    }
}

