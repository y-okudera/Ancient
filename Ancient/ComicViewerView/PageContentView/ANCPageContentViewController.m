//
//  ANCPageContentViewController.m
//  Ancient
//
//  Created by Yuki Okudera on 2023/06/24.
//

#import "ANCPageContentViewController.h"
#import "UIApplication+ANCCurrentWindowInterfaceOrientation.h"

@interface ANCPageContentViewController ()

/// 見開きの場合は左側、シングルページの場合は非表示
@property (nonatomic, strong) UIImageView *leftImageView;

/// 見開きの場合は右側、シングルページの場合は表示
@property (nonatomic, strong) UIImageView *rightImageView;

- (void)setUpImageViews;
- (void)loadImage;
- (void)loadImageWithURLString:(NSString *)urlString destination:(UIImageView *)imageView;

@end

@implementation ANCPageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpImageViews];
    [self loadImage];
}

#pragma mark - UIContentContainer

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize: size withTransitionCoordinator: coordinator];

    [coordinator animateAlongsideTransition: ^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        [self loadImage];
    } completion: nil];
}

#pragma mark - class extension

- (void)setUpImageViews {
    self.leftImageView = [[UIImageView alloc] init];
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.leftImageView];

    self.rightImageView = [[UIImageView alloc] init];
    self.rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.rightImageView];
}

- (void)loadImage {
    UIInterfaceOrientation orientation = [UIApplication currentInterfaceOrientation];
    // Whether the device orientation is Portrait or not.
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        self.leftImageView.hidden = YES;
        [self loadImageWithURLString: self.imageURL1 destination: self.rightImageView];
    } else {
        self.leftImageView.hidden = NO;
        [self loadImageWithURLString: self.imageURL1 destination: self.rightImageView];
        [self loadImageWithURLString: self.imageURL2 destination: self.leftImageView];
    }
}

- (void)loadImageWithURLString:(NSString *)urlString destination:(UIImageView *)imageView {
    if ([urlString isEqualToString: @""]) {
        imageView.image = [[UIImage alloc] init];
        return;
    }
    // Asynchronously load the image from the imageURL
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString: urlString];
        NSData *data = [NSData dataWithContentsOfURL: url];
        UIImage *image = [UIImage imageWithData: data];

        // When the image has been loaded, update the imageView on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;

            UIInterfaceOrientation orientation = [UIApplication currentInterfaceOrientation];
            if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
                // 比率を維持して画面幅いっぱいにする
                CGFloat ratio = image.size.height / image.size.width;
                CGSize imageViewSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width * ratio);

                CGFloat imageViewOriginY = (UIScreen.mainScreen.bounds.size.height - imageViewSize.height) / 2;

                if ([imageView isEqual: self.rightImageView]) {
                    [imageView setFrame: CGRectMake(0, imageViewOriginY, imageViewSize.width, imageViewSize.height)];
                }

            } else {

                // 横長の画像の場合
                if (image.size.width > image.size.height) {

                    // 比率を維持して画面幅の半分の幅にする
                    CGFloat ratio = image.size.height / image.size.width;
                    CGSize imageViewSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width / 2, UIScreen.mainScreen.bounds.size.width / 2 * ratio);

                    CGFloat imageViewOriginY = (UIScreen.mainScreen.bounds.size.height - imageViewSize.height) / 2;

                    if ([imageView isEqual: self.rightImageView]) {
                        [imageView setFrame: CGRectMake(imageViewSize.width, imageViewOriginY, imageViewSize.width - self.view.safeAreaInsets.right, imageViewSize.height)];
                    } else if ([imageView isEqual:self.leftImageView]) {
                        [imageView setFrame: CGRectMake(self.view.safeAreaInsets.left, imageViewOriginY, imageViewSize.width - self.view.safeAreaInsets.left, imageViewSize.height)];
                    }

                    // 縦長の画像の場合
                } else if (image.size.width < image.size.height) {

                    // 比率を維持して画面の高さいっぱいにする
                    CGFloat ratio = image.size.width / image.size.height;
                    CGSize imageViewSize = CGSizeMake(UIScreen.mainScreen.bounds.size.height * ratio, UIScreen.mainScreen.bounds.size.height);

                    if ([imageView isEqual:self.rightImageView]) {
                        [imageView setFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width / 2, 0, imageViewSize.width, imageViewSize.height)];
                    } else if ([imageView isEqual:self.leftImageView]) {
                        [imageView setFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width / 2 - imageViewSize.width, 0, imageViewSize.width, imageViewSize.height)];
                    }
                } else {
                    // 正方形
                }
            }
        });
    });
}

@end
