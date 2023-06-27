//
//  ANCPageController.h
//  Ancient
//
//  Created by Yuki Okudera on 2023/06/25.
//

#import <UIKit/UIKit.h>
#import <AncientComicViewerView/ANCPageContentViewController.h>
#import <AncientComicViewerView/ANCViewerContentData.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANCPageController : NSObject <UIPageViewControllerDataSource>

@property (assign, nonatomic) NSInteger currentIndex;
@property (readonly, strong, nonatomic) ANCViewerContentData *viewerContentData;

- (instancetype)initWithViewerContentData:(ANCViewerContentData *)viewerContentData;
- (ANCPageContentViewController *)viewControllerAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
