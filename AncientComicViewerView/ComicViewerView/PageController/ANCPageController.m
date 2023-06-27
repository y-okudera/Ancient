//
//  ANCPageController.m
//  Ancient
//
//  Created by Yuki Okudera on 2023/06/25.
//

#import "ANCPageController.h"
#import "UIApplication+ANCCurrentWindowInterfaceOrientation.h"

@interface ANCPageController ()

@property (readwrite, strong, nonatomic) ANCViewerContentData *viewerContentData;

- (NSUInteger)indexOfViewController:(ANCPageContentViewController *)viewController;

@end

@implementation ANCPageController

#pragma mark - public

- (instancetype)initWithViewerContentData:(ANCViewerContentData *)viewerContentData {
    self = [super init];
    if (self) {
        self.viewerContentData = viewerContentData;
    }
    return self;
}

- (ANCPageContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    // Return the data view controller for the given index.
    if ((self.viewerContentData.singlePageData.count == 0) || (index >= self.viewerContentData.singlePageData.count)) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    ANCPageContentViewController *pageContentViewController = [[ANCPageContentViewController alloc] init];

    UIInterfaceOrientation orientation = [UIApplication currentInterfaceOrientation];
    // Whether the device orientation is Portrait or not.
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        if ((self.viewerContentData.singlePageData.count != 0) && (index < self.viewerContentData.singlePageData.count)) {
            pageContentViewController.imageURL1 = self.viewerContentData.singlePageData[index];
        }
    } else {
        if ((self.viewerContentData.rightPageData.count != 0) && (index < self.viewerContentData.rightPageData.count)) {
            pageContentViewController.imageURL1 = self.viewerContentData.rightPageData[index];
        }
        if ((self.viewerContentData.leftPageData.count != 0) && (index < self.viewerContentData.leftPageData.count)) {
            pageContentViewController.imageURL2 = self.viewerContentData.leftPageData[index];
        }
    }
    self.currentIndex = index;
    return pageContentViewController;
}

#pragma mark - class extension

- (NSUInteger)indexOfViewController:(ANCPageContentViewController *)viewController {
    UIInterfaceOrientation orientation = [UIApplication currentInterfaceOrientation];
    // Whether the device orientation is Portrait or not.
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return [self.viewerContentData.singlePageData indexOfObject: viewController.imageURL1];
    } else {
        return [self.viewerContentData.rightPageData indexOfObject: viewController.imageURL1];
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
        if (index == self.viewerContentData.singlePageData.count) {
            return nil;
        }
    } else {
        if (index == self.viewerContentData.rightPageData.count) {
            return nil;
        }
    }

    return [self viewControllerAtIndex:index];
}

@end
