//
//  ANCPageController.m
//  Ancient
//
//  Created by Yuki Okudera on 2023/06/25.
//

#import "ANCPageController.h"
#import "ANCPageContentViewController.h"
#import "UIApplication+ANCCurrentWindowInterfaceOrientation.h"

@interface ANCPageController ()

@property (readwrite, strong, nonatomic) NSArray<NSString *> *pageMasterData;
@property (readwrite, strong, nonatomic) NSArray<NSString *> *singlePageData;
@property (readwrite, strong, nonatomic) NSArray<NSString *> *rightPageData;
@property (readwrite, strong, nonatomic) NSArray<NSString *> *leftPageData;

- (void)updatePageData;
- (void)updateSinglePageData;
- (void)updateSpreadPageData;
- (NSUInteger)indexOfViewController:(ANCPageContentViewController *)viewController;

@end

@implementation ANCPageController

- (instancetype)init {
    self = [super init];
    if (self) {
        // MARK: - 画面回転時、画像URLからindexを取得するため、テストデータであっても配列内に画像URLが重複しないよう考慮が必要
        self.pageMasterData = @[
            @"https://affi-drifter.com/wp-content/uploads/2018/05/20170828180155-320x186.jpg",
            @"https://grapee.jp/wp-content/uploads/57507_01.jpg",
            @"https://grapee.jp/wp-content/uploads/57507_02.jpg",
            @"https://grapee.jp/wp-content/uploads/57507_03.jpg",
            @"https://grapee.jp/wp-content/uploads/57507_04.jpg",
            @"https://ichef.bbci.co.uk/news/467/cpsprodpb/660A/production/_122722162_download.png",
        ];
        [self updatePageData];
    }
    return self;
}

- (void)updatePageData {
    [self updateSinglePageData];
    [self updateSpreadPageData];
}

- (void)updateSinglePageData {
    self.singlePageData = [self.pageMasterData copy];
}

- (void)updateSpreadPageData {

    NSMutableArray<NSString *> *mutableSpreadPageData = [self.pageMasterData mutableCopy];
    [mutableSpreadPageData insertObject: @"" atIndex: 0];
    if (mutableSpreadPageData.count % 2 != 0) {
        [mutableSpreadPageData addObject: @""];
    }
    NSArray<NSString *> *spreadPageData = [mutableSpreadPageData copy];

    NSMutableArray *rightPageData = [NSMutableArray array];
    NSMutableArray *leftPageData = [NSMutableArray array];
    [spreadPageData enumerateObjectsUsingBlock: ^(NSString *data, NSUInteger index, BOOL *stop) {
        if (index % 2 == 0) {
            [rightPageData addObject: data];
        } else {
            [leftPageData addObject: data];
        }
    }];
    self.rightPageData = [rightPageData copy];
    self.leftPageData = [leftPageData copy];
}

- (ANCPageContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    // Return the data view controller for the given index.
    if ((self.singlePageData.count == 0) || (index >= self.singlePageData.count)) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"ANCPageContentViewController" bundle: [NSBundle mainBundle]];
    ANCPageContentViewController *pageContentViewController = [storyboard instantiateViewControllerWithIdentifier: @"ANCPageContentViewController"];

    UIInterfaceOrientation orientation = [UIApplication currentInterfaceOrientation];
    // Whether the device orientation is Portrait or not.
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        if ((self.singlePageData.count != 0) && (index < self.singlePageData.count)) {
            pageContentViewController.imageURL1 = self.singlePageData[index];
        }
    } else {
        if ((self.rightPageData.count != 0) && (index < self.rightPageData.count)) {
            pageContentViewController.imageURL1 = self.rightPageData[index];
        }
        if ((self.leftPageData.count != 0) && (index < self.leftPageData.count)) {
            pageContentViewController.imageURL2 = self.leftPageData[index];
        }
    }
    self.currentIndex = index;
    return pageContentViewController;
}

- (NSUInteger)indexOfViewController:(ANCPageContentViewController *)viewController {
    UIInterfaceOrientation orientation = [UIApplication currentInterfaceOrientation];
    // Whether the device orientation is Portrait or not.
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return [self.singlePageData indexOfObject: viewController.imageURL1];
    } else {
        return [self.rightPageData indexOfObject: viewController.imageURL1];
    }
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController: (ANCPageContentViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;

    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController: (ANCPageContentViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;

    UIInterfaceOrientation orientation = [UIApplication currentInterfaceOrientation];
    // Whether the device orientation is Portrait or not.
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        if (index == self.singlePageData.count) {
            return nil;
        }
    } else {
        if (index == self.rightPageData.count) {
            return nil;
        }
    }

    return [self viewControllerAtIndex:index];
}

@end
