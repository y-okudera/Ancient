//
//  ANCViewerContentData.m
//  AncientComicViewerView
//
//  Created by okudera on 2023/06/27.
//

#import "ANCViewerContentData.h"

@interface ANCViewerContentData ()

@property (readwrite, strong, nonatomic) NSString *title;
@property (readwrite, strong, nonatomic) NSArray<NSString *> *pageMasterData;
@property (readwrite, strong, nonatomic) NSArray<NSString *> *singlePageData;
@property (readwrite, strong, nonatomic) NSArray<NSString *> *rightPageData;
@property (readwrite, strong, nonatomic) NSArray<NSString *> *leftPageData;

- (void)updateSinglePageData;
- (void)updateSpreadPageData;

@end

@implementation ANCViewerContentData

#pragma mark - public

- (instancetype)initWithPageMasterData:(NSArray<NSString *> *)pageMasterData title:(NSString *)title {
    self = [super init];
    if (self) {
        self.pageMasterData = pageMasterData;
        self.title = title;
        [self updateSinglePageData];
        [self updateSpreadPageData];
    }
    return self;
}

#pragma mark - class extension

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

@end
