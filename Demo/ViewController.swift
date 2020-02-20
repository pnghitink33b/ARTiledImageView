//
//  ViewController.swift
//  Demo
//
//  Created by Nghi Phan on 2/18/20.
//  Copyright © 2020 Artsy. All rights reserved.
//

import UIKit
import ARTiledImageView

class MarkerView: UIImageView {
    let mapPosition: CGPoint
    init(frame: CGRect, mapPosition: CGPoint) {
        self.mapPosition = mapPosition
        super.init(frame: frame)
        self.image = #imageLiteral(resourceName: "stageinformation")
        self.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController, ARTiledImageScrollViewDelegate {
    var _ds: ARTiledImageViewDataSource?
    var _scrollView: ARTiledImageScrollView!
    var markerViews: [MarkerView] = []
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
        //
//        let localDataSource = ARLocalTiledImageDataSource()
//        var resourceURL = Bundle.main.resourceURL!
//        resourceURL.appendPathComponent("Tiles/Sample30MB/tiles")
//        localDataSource.tileBasePath = resourceURL.path
        
        let localDataSource = ARWebTiledImageDataSource()
        localDataSource.tileBaseURL = URL(string: "https://raw.githubusercontent.com/pnghitink33b/ARTiledImageView/master/Demo/Tiles/Wallpaper/tiles")
        
        let size = CGSize(width: 13583, height: 5417) //CGSizeMake(2383, 2933)
        localDataSource.maxTiledHeight = Int(size.height)
        localDataSource.maxTiledWidth = Int(size.width)
        localDataSource.minTileLevel = 0;
        localDataSource.maxTileLevel = 14;
        localDataSource.tileSize = 512
        localDataSource.tileFormat = "jpg"
        _ds = localDataSource
        

        let scrollView = ARTiledImageScrollView(frame: self.view.bounds.insetBy(dx: 10, dy: 10))
        _scrollView = scrollView
        scrollView.tiledImageScrollViewDelegate = self
        scrollView.clipsToBounds = false
        scrollView.centerOnZoomOut = true
//        scrollView.imagePadding = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        scrollView.contentMode = .scaleAspectFit
        scrollView.dataSource = localDataSource
        scrollView.backgroundColor = .clear
        scrollView.displayTileBorders = true
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
//        sv.displayTileBorders = true
         self.view.addSubview(scrollView)
//        scrollView.tiledInset = .init(top: 100, left: 100, bottom: 100, right: 100)
        scrollView.zoom(toFit: false)
        
        let markerView = MarkerView(frame: .init(origin: .zero, size: .init(width: 10, height: 10)), mapPosition: .init(x: 5780, y: 1267))
//        markerView.backgroundColor = .red
        markerViews.append(markerView)
        view.addSubview(markerView)
        updateMarkerPosition()
    }

    func tiledImageScrollViewDidScroll(_ scrollView: ARTiledImageScrollView) {
        updateMarkerPosition()
    }
    
    func tiledImageScrollViewDidZoom(_ scrollView: ARTiledImageScrollView) {
        updateMarkerPosition()
    }

    func tiledImageScrollViewDidEndZooming(_ scrollView: ARTiledImageScrollView, with view: UIView?, atScale scale: CGFloat) {
        updateMarkerPosition()
    }
    
    func updateMarkerPosition() {
        guard let tiledImageView = _scrollView.imageBackedTiledImageView?.tiledImageView else {
            return
        }
        markerViews.forEach { markerView in
            let origin = self.view.convert(markerView.mapPosition, from: tiledImageView)
            markerView.frame.origin = origin
        }
    }
}

