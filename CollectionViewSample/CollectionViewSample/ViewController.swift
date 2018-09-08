//
//  ViewController.swift
//  CollectionViewSample
//
//  Created by 許　駿 on 2018/04/27.
//  Copyright © 2018年 kyo_s. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let refreshControl = UIRefreshControl()

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.delegate = self

        // MARK: -- リロードを行う
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(ViewController.refresh(sender:)), for: .valueChanged)
    }

    // MARK: -- リロード処理の中身
    @objc func refresh(sender: UIRefreshControl) {
        // ここに通信処理などデータフェッチの処理を書く
        // 処理が終わった際には、refreshControl.endRefreshing()を呼んでリロードをなくす
        refreshControl.endRefreshing()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -- アラートの表示を行う。
    @IBAction func alsertButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "actiontitle", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as! SampleCollectionViewCell
        cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        cell.sampleLabel.text = "sampleLabel\(indexPath.row)"
        cell.sampleTextField.text = "sampleTextFIled\(indexPath.row)"
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "保存してもいいですか？", preferredStyle:  UIAlertControllerStyle.actionSheet)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
        }
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}

