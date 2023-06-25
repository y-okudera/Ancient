//
//  ANCComicViewerViewController.m
//  Ancient
//
//  Created by Yuki Okudera on 2023/06/24.
//

#import "ANCComicViewerViewController.h"
#import "ANCPageController.h"
#import "ANCPageContentViewController.h"
#import "UIApplication+ANCCurrentWindowInterfaceOrientation.h"

@interface ANCComicViewerViewController ()

@property (strong, nonatomic) ANCPageController *pageController;

- (void)setContentViewControllerAtIndex:(NSUInteger)index;

@end

@implementation ANCComicViewerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pageController = [[ANCPageController alloc] init];

    // Create the initial content view controller
    [self setContentViewControllerAtIndex: 0];

    self.dataSource = self.pageController;
    self.delegate = self;
    self.view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
}

#pragma mark - UIContentContainer

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize: size withTransitionCoordinator: coordinator];

    [coordinator animateAlongsideTransition: ^(id<UIViewControllerTransitionCoordinatorContext> context) {
        ANCPageContentViewController *pageContentVC = self.viewControllers.firstObject;

        NSUInteger singlePageDataIndex = [self.pageController.singlePageData indexOfObject: pageContentVC.imageURL1];
        singlePageDataIndex = singlePageDataIndex == NSNotFound ? 0 : singlePageDataIndex;

        NSUInteger spreadPageDataIndex = [self.pageController.rightPageData indexOfObject: pageContentVC.imageURL1];
        if (spreadPageDataIndex == NSNotFound) {
            spreadPageDataIndex = [self.pageController.leftPageData indexOfObject: pageContentVC.imageURL1];
        }
        spreadPageDataIndex = spreadPageDataIndex == NSNotFound ? 0 : spreadPageDataIndex;

#if DEBUG
        NSLog(@"imageURL1: %@ imageURL2: %@", pageContentVC.imageURL1, pageContentVC.imageURL2);
        NSLog(@"singlePageDataIndex: %lu spreadPageDataIndex: %lu", singlePageDataIndex, spreadPageDataIndex);
#endif

        UIInterfaceOrientation orientation = [UIApplication currentInterfaceOrientation];
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
            self.pageController.currentIndex = singlePageDataIndex;
        } else {
            self.pageController.currentIndex = spreadPageDataIndex;
        }
        [self setContentViewControllerAtIndex: self.pageController.currentIndex];
    } completion: nil];
}

#pragma mark - UIPageViewControllerDelegate

- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - class extension

- (void)setContentViewControllerAtIndex:(NSUInteger)index {
    // Create the page view controller
    ANCPageContentViewController *pageContentViewController = [self.pageController viewControllerAtIndex: index];
    NSArray<UIViewController *> *viewControllers = @[pageContentViewController];
    [self setViewControllers: viewControllers direction: UIPageViewControllerNavigationDirectionForward animated: NO completion: nil];

    // animatedをYESにする場合はキャッシュ更新の考慮が必要
//    __block ANCComicViewerViewController *weakRef = self;
//    [self setViewControllers: viewControllers
//                   direction: UIPageViewControllerNavigationDirectionForward
//                    animated: YES
//                  completion: ^(BOOL finished) {
//        if (!finished) {
//            return;
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakRef setViewControllers: viewControllers
//                              direction: UIPageViewControllerNavigationDirectionForward
//                               animated: NO
//                             completion: nil
//            ];
//        });
//    }];
}

@end
