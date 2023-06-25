//
//  ANCPageContentViewController.m
//  Ancient
//
//  Created by Yuki Okudera on 2023/06/24.
//

#import "ANCPageContentViewController.h"
#import "UIApplication+ANCCurrentWindowInterfaceOrientation.h"

@interface ANCPageContentViewController ()

/// 見開きの場合は右側、シングルページの場合は表示
@property (strong, nonatomic) IBOutlet UIImageView *imageView1;

/// 見開きの場合は左側、シングルページの場合は非表示
@property (strong, nonatomic) IBOutlet UIImageView *imageView2;

- (void)loadImage;
- (void)loadImageWithURLString:(NSString *)urlString destination:(UIImageView *)imageView;
@end

@implementation ANCPageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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

- (void)loadImage {
    UIInterfaceOrientation orientation = [UIApplication currentInterfaceOrientation];
    // Whether the device orientation is Portrait or not.
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        self.imageView2.hidden = YES;
        [self loadImageWithURLString: self.imageURL1 destination: self.imageView1];
    } else {
        self.imageView2.hidden = NO;
        [self loadImageWithURLString: self.imageURL1 destination: self.imageView1];
        [self loadImageWithURLString: self.imageURL2 destination: self.imageView2];
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
        });
    });
}

@end
