//
//  ViewController.swift
//  Demo
//
//  Created by Nghi Phan on 2/18/20.
//  Copyright © 2020 Artsy. All rights reserved.
//

import UIKit
import ARTiledImageView

class ViewController: UIViewController {
    var _ds: ARTiledImageViewDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let ds = ARWebTiledImageDataSource()
//        // height of the full zoomed in image
//        ds.maxTiledHeight = 2933;
//        // width of the full zommed in image
//        ds.maxTiledWidth = 2383;
//        // width of the full zommed in image
//        ds.minTileLevel = 10;
//        // maximum tile level
//        ds.maxTileLevel = 15;
//        // side of a square tile
//        ds.tileSize = 512;
//        // tile format
//        ds.tileFormat = "jpg";
//        // location of tiles, organized in subfolders, one per level
//        ds.tileBaseURL = URL(string: "https://raw.github.com/dblock/ARTiledImageView/master/Demo/Tiles/SenoraSabasaGarcia/tiles")
//        // make sure to retain the datasource
//        _ds = ds
        
        let localDataSource = ARLocalTiledImageDataSource()
        var resourceURL = Bundle.main.resourceURL!
        resourceURL.appendPathComponent("Tiles/Wallpaper/tiles")
        localDataSource.tileBasePath = resourceURL.path
        
        let size = CGSize(width: 15360, height: 8640) //CGSizeMake(2383, 2933)
        localDataSource.maxTiledHeight = Int(size.height)
        localDataSource.maxTiledWidth = Int(size.width)
        localDataSource.minTileLevel = 1;
        localDataSource.maxTileLevel = 14;
        localDataSource.tileSize = 256
        localDataSource.tileFormat = "jpg"
        _ds = localDataSource
        
        
        let viewRatio = self.view.bounds.width/self.view.bounds.height
        let imageRatio = size.width/size.height
            
        let useWidth: Bool
        switch (viewRatio, imageRatio) {
        case (let x, let y) where x >= y:
            useWidth = false
        case (let x, let y) where x < y:
            useWidth = true
        default:
            fatalError("Imposiblee case")
        }
        
        
        let scrollView = ARTiledImageScrollView(frame: self.view.bounds)
        scrollView.dataSource = localDataSource
        scrollView.backgroundColor = .gray
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
//        sv.displayTileBorders = true
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
         self.view.addSubview(scrollView)
//        if useWidth {
//            NSLayoutConstraint.activate([
//                scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//                scrollView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1/imageRatio)
//            ])
//        } else {
//            NSLayoutConstraint.activate([
//                scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
//                scrollView.widthAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: imageRatio)
//            ])
//        }
//
//        scrollView.widthAnchor.cen
    }


}

