//
//  ViewController.swift
//  mkMapViewSample
//
//  Created by 許　駿 on 2019/08/15.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    // 現在地の取得
    var locManager: CLLocationManager!

    // ロングタップの検知
    @IBOutlet var longPressGetRec: UILongPressGestureRecognizer!

    @IBOutlet weak var longTapStatus: UILabel!
    @IBOutlet weak var tapLog: UILabel!
    @IBOutlet weak var tapLat: UILabel!
    @IBOutlet weak var address: UITextField!



    override func viewDidLoad() {
        super.viewDidLoad()

        locManager = CLLocationManager()
        locManager.delegate = self

        // 位置情報の使用許可
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                locManager.startUpdatingLocation()
                break
            default:
                break
            }
        }

        initMap()
    }

    // ロングタップの検知
    @IBAction func mapViewDidLongPress(_ sender: UILongPressGestureRecognizer) {

        // ロングタップの開始
        if sender.state == .began {
            longTapStatus.text = "LongTapStatus: began"
        } else if sender.state == .ended { // ロングタップ終了（手を話した）
            longTapStatus.text = "LongTapStatus: ended"
            // tapした位置の緯度経度のそ取得
            let tapPoint = sender.location(in: view)
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            tapLog.text = "tapLon: \(center.longitude.description)"
            tapLat.text = "tapLat: \(center.latitude.description)"
        }
    }

    @IBAction func search(_ sender: UIButton) {
        let myGeocoder = CLGeocoder()
        guard let address = self.address.text else {
            return
        }
        myGeocoder.geocodeAddressString(address) {(placemarks,error) in
            if error == nil {
                for placemark in placemarks! {
                    let location = placemark.location!
                    //中心座標
                    let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)

                    //表示範囲
                    let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)

                    //中心座標と表示範囲をマップに登録する。
                    let region = MKCoordinateRegion(center: center, span: span)
                    self.mapView.setRegion(region, animated:true)

                    //地図にピンを立てる。
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }


    // マップの表示サイズ
    func initMap() {
        var region: MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region, animated: true)

        mapView.showsUserLocation = true
        
        mapView.userTrackingMode = .follow
    }

    // 現在地の更新処理
    func updateCurrentPos(_ coodinate: CLLocationCoordinate2D) {
        var region: MKCoordinateRegion = mapView.region
        region.center = coodinate
        mapView.setRegion(region, animated: true)
    }
}

extension ViewController: CLLocationManagerDelegate {
    // 現在地が更新された際に呼び出される
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let longStr = (locations.last?.coordinate.longitude.description)!
        let latStr = (locations.last?.coordinate.latitude.description)!

        print("log : " + longStr)
        print("lat : " + latStr)
        // マップの中心を現在地に更新
//        updateCurrentPos((locations.last?.coordinate)!)
        //mapView.userTrackingMode = .follow
    }
}

extension ViewController: UIGestureRecognizerDelegate {

}
