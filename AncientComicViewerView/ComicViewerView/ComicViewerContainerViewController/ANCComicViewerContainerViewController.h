//
//  ANCComicViewerContainerViewController.h
//  Ancient
//
//  Created by Yuki Okudera on 2023/06/25.
//

#import <UIKit/UIKit.h>
#import <AncientComicViewerView/ANCViewerContentData.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANCComicViewerContainerViewController : UIViewController

- (void)addComicViewerViewWithContentData:(ANCViewerContentData *)viewerContentData;
- (void)setUpPageSliderRange;
- (void)updatePageSliderValue:(NSUInteger)value;
- (void)hideToolbar;

@end

NS_ASSUME_NONNULL_END
