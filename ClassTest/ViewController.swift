//
//  ViewController.swift
//  ClassTest
//
//  Created by Stefan on 2021/3/30.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {
    let cellIdentifier = "localCell"
    var dataArray = [VGModel]()
    var dataSub: BehaviorSubject<[VGModel]>?
    let disposeBag = DisposeBag()
    fileprivate lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(LocalDataCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        self.addRightBtn()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 88, left: 0, bottom: 0, right: 0))
        }
        
        dataSub = BehaviorSubject(value: dataArray)
        
        dataSub?.subscribe(onNext: { [weak self](items) in
            self?.dataArray = items
            self?.tableView.reloadData()
        })
        .disposed(by: disposeBag)
    }

    func addRightBtn() {

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(didClickAdd))
    }
    
    @objc func didClickAdd() {
        self.pushToSecVc(model: nil, indxe: IndexPath(row: -1, section: 0))
    }
    
    fileprivate func pushToSecVc(model: VGModel?, indxe: IndexPath?) {
        let vc = SecondViewController()
        
        if let model = model {
            vc.model = model
        }
        if let index = indxe {
            vc.indxep = index
        }
        vc.todoOB.subscribe(onNext: { [weak self](itms, indexf) in
            
            if indexf.row == -1 {
                self?.dataArray.append(itms)
            }else{
                self?.dataArray[indexf.row] = itms
            }
            
            self?.dataSub?.onNext(self?.dataArray ?? [])
        })
        .disposed(by: disposeBag)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LocalDataCell
        cell.updateWithModel(model: dataArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArray[indexPath.row]
        self.pushToSecVc(model: model, indxe: indexPath)
    }
    
    
}