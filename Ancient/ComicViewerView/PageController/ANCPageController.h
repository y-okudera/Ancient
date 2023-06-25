//
//  ANCPageController.h
//  Ancient
//
//  Created by Yuki Okudera on 2023/06/25.
//

#import <UIKit/UIKit.h>
@class ANCPageContentViewController;

NS_ASSUME_NONNULL_BEGIN

@interface ANCPageController : NSObject <UIPageViewControllerDataSource>

@property (assign, nonatomic) NSInteger currentIndex;

@property (readonly, strong, nonatomic) NSArray<NSString *> *pageMasterData;
@property (readonly, strong, nonatomic) NSArray<NSString *> *singlePageData;
@property (readonly, strong, nonatomic) NSArray<NSString *> *rightPageData;
@property (readonly, strong, nonatomic) NSArray<NSString *> *leftPageData;

- (ANCPageContentViewController *)viewControllerAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
