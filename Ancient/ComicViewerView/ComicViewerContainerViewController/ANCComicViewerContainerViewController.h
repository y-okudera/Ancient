//
//  ANCComicViewerContainerViewController.h
//  Ancient
//
//  Created by Yuki Okudera on 2023/06/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANCComicViewerContainerViewController : UIViewController

- (void)setUpPageSliderRange;
- (void)updatePageSliderValue:(NSUInteger)value;
- (void)updateToolbarTitle:(NSString *)title;
- (void)hideToolbar;

@end

NS_ASSUME_NONNULL_END
