//
//  ANCViewerContentData.h
//  AncientComicViewerView
//
//  Created by okudera on 2023/06/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ANCViewerContentData : NSObject

@property (readonly, strong, nonatomic) NSString *title;
@property (readonly, strong, nonatomic) NSArray<NSString *> *pageMasterData;
@property (readonly, strong, nonatomic) NSArray<NSString *> *singlePageData;
@property (readonly, strong, nonatomic) NSArray<NSString *> *rightPageData;
@property (readonly, strong, nonatomic) NSArray<NSString *> *leftPageData;

- (instancetype)initWithPageMasterData:(NSArray<NSString *> *)pageMasterData title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
