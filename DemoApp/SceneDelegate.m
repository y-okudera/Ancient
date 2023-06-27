//
//  SceneDelegate.m
//  DemoApp
//
//  Created by Yuki Okudera on 2023/06/27.
//

#import <AncientComicViewerView/ANCComicViewerContainerViewController.h>
#import "SceneDelegate.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    [self.window makeKeyAndVisible];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"ANCComicViewerContainerViewController" bundle: [NSBundle bundleForClass:[ANCComicViewerContainerViewController class]]];
    ANCComicViewerContainerViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ANCComicViewerContainerViewController"];

    // MARK: - 画面回転時、画像URLからindexを取得するため、テストデータであっても配列内に画像URLが重複しないよう考慮が必要
    NSArray<NSString *> *pageMasterData = @[
        @"https://affi-drifter.com/wp-content/uploads/2018/05/20170828180155-320x186.jpg",
        @"https://grapee.jp/wp-content/uploads/57507_01.jpg",
        @"https://grapee.jp/wp-content/uploads/57507_02.jpg",
        @"https://grapee.jp/wp-content/uploads/57507_03.jpg",
        @"https://grapee.jp/wp-content/uploads/57507_04.jpg",
        @"https://ichef.bbci.co.uk/news/467/cpsprodpb/660A/production/_122722162_download.png",
    ];

    ANCViewerContentData *viewerContentData = [[ANCViewerContentData alloc] initWithPageMasterData: pageMasterData title: @"サンプル漫画 - 123"];
    [vc addComicViewerViewWithContentData: viewerContentData];
    self.window.rootViewController = vc;
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
