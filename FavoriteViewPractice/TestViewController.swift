//
//  TestViewController.swift
//  FavoriteViewPractice
//
//  Created by 藤田和磨 on 2019/01/10.
//  Copyright © 2019 藤田和磨. All rights reserved.
//

import UIKit
import MapKit

class TestViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 緯度・経度を設定
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.7210914, 139.9272341)
        mapView.setCenter(location, animated: true)
        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        region.center = location
        mapView.setRegion(region, animated: true)
        // デフォルトマップ表示
        mapView.mapType = MKMapType.standard
        // 各操作禁止
        mapView.isScrollEnabled = false // スクロール
        mapView.isRotateEnabled = false // 回転
        mapView.isZoomEnabled = false // ズーム
        mapView.isPitchEnabled = false // 3D表示
        // ピンを生成
        let pin: MKPointAnnotation = MKPointAnnotation()
        pin.coordinate = location
        pin.title = "GENOVAクリニック"
        pin.subtitle = "渋谷区宇田川町10-2 SHIBUYA EDGE BUILD. 5F"
        mapView.addAnnotation(pin)
        mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:))))
    }


    @objc func handleMapTap(sender: UITapGestureRecognizer) {
        
        let daddr = NSString(format: "%f,%f", 35.7210914, 139.9272341)
        
        // TODO: ↓現在地からのルート検索は以下を使う
        // let mapUrl = "https://maps.apple.com/?t=m&daddr=\(daddr)&dirflg=d"
        let mapUrl = "https://maps.apple.com/?t=m&ll=\(daddr)"
        // let encodedUrl = mapUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.alphanumerics)!
        // let url = URL(string: mapUrl)!
        UIApplication.shared.open(URL(string: mapUrl)!, options: [:], completionHandler: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
