//
//  ANCComicViewerViewController.h
//  Ancient
//
//  Created by Yuki Okudera on 2023/06/24.
//

#import <UIKit/UIKit.h>
#import "ANCPageController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ANCComicViewerViewController : UIPageViewController <UIPageViewControllerDelegate>

@property (readonly, strong, nonatomic) ANCPageController *pageController;

- (void)setContentViewControllerAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
