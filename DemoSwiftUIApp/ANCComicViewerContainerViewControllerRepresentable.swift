//
//  ANCComicViewerContainerViewControllerRepresentable.swift
//  DemoSwiftUIApp
//
//  Created by okudera on 2023/06/27.
//

import AncientComicViewerView
import SwiftUI
import UIKit

struct ANCComicViewerContainerViewControllerRepresentable : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ANCComicViewerContainerViewController {

        let storyboard = UIStoryboard(
            name: "ANCComicViewerContainerViewController",
            bundle: Bundle(for: ANCComicViewerContainerViewController.self)
        )
        let comicViewerContainerVC = storyboard.instantiateViewController(
            withIdentifier: "ANCComicViewerContainerViewController"
        ) as! ANCComicViewerContainerViewController

        let pageMasterData = [
            "https://affi-drifter.com/wp-content/uploads/2018/05/20170828180155-320x186.jpg",
            "https://grapee.jp/wp-content/uploads/57507_01.jpg",
            "https://grapee.jp/wp-content/uploads/57507_02.jpg",
            "https://grapee.jp/wp-content/uploads/57507_03.jpg",
            "https://grapee.jp/wp-content/uploads/57507_04.jpg",
            "https://ichef.bbci.co.uk/news/467/cpsprodpb/660A/production/_122722162_download.png",
        ]
        let viewerContentData = ANCViewerContentData(pageMasterData: pageMasterData, title: "DemoSwiftUIApp サンプル漫画")
        comicViewerContainerVC.addComicViewerView(with: viewerContentData)

        return comicViewerContainerVC
    }

    func updateUIViewController(_ uiViewController: ANCComicViewerContainerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {

    }
}

struct ANCComicViewerContainerViewControllerRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        ANCComicViewerContainerViewControllerRepresentable()
    }
}
