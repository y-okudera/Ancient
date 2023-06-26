//
//  ANCComicViewerContainerViewController.m
//  Ancient
//
//  Created by Yuki Okudera on 2023/06/25.
//

#import "ANCComicViewerContainerViewController.h"
#import "ANCComicViewerViewController.h"
#import "UIApplication+ANCCurrentWindowInterfaceOrientation.h"

@interface ANCComicViewerContainerViewController ()

@property (weak, nonatomic) IBOutlet UIView *headerSafeAreaView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISlider *pageSlider;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousButton;

- (void)addComicViewerView;
- (void)setUpToolbar;
- (void)toggleToolbar:(UITapGestureRecognizer *)recognizer;
- (void)showToolbar;

@end

@implementation ANCComicViewerContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addComicViewerView];
    [self setUpToolbar];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    // スライダーの現在の値を取得し、整数値に変換
    NSInteger pageIndex = round(self.pageSlider.value);
    sender.value = pageIndex;

    // スライダーの最小値と最大値を設定
    [self setUpPageSliderRange];

    ANCComicViewerViewController *vc = [[self childViewControllers] firstObject];
    if (vc.pageController.currentIndex == pageIndex) {
        return;
    }
    // 新しいページを作成し、表示
    vc.pageController.currentIndex = pageIndex;
    [vc setContentViewControllerAtIndex: vc.pageController.currentIndex];
}

- (IBAction)didTapNextButton:(UIBarButtonItem *)sender {
#if DEBUG
    NSLog(@"次の話ボタンタップ");
#endif
}

- (IBAction)didTapPreviousButton:(UIBarButtonItem *)sender {
#if DEBUG
    NSLog(@"前の話ボタンタップ");
#endif
}

#pragma mark - public

- (void)setUpPageSliderRange {
    self.pageSlider.minimumValue = 0;
    ANCComicViewerViewController *vc = [[self childViewControllers] firstObject];
    UIInterfaceOrientation orientation = [UIApplication currentInterfaceOrientation];
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        self.pageSlider.maximumValue = vc.pageController.singlePageData.count - 1;
    } else {
        self.pageSlider.maximumValue = vc.pageController.rightPageData.count - 1;
    }
}

- (void)updatePageSliderValue:(NSUInteger)value {
    [self.pageSlider setValue: value animated: YES];
}

- (void)updateToolbarTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)hideToolbar {
    [UIView animateWithDuration: 0.4 animations:^{
        self.headerSafeAreaView.alpha = 0.0;
        self.headerView.alpha = 0.0;
        self.toolbar.alpha = 0.0;
        self.pageSlider.alpha = 0.0;
    }];
}

#pragma mark - class extension

- (void)addComicViewerView {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"ANCComicViewerViewController" bundle: [NSBundle bundleForClass:[ANCComicViewerViewController class]]];
    ANCComicViewerViewController *vc = [storyboard instantiateViewControllerWithIdentifier: @"ANCComicViewerViewController"];
    [vc willMoveToParentViewController: self];
    [self addChildViewController:vc];
    [vc.view setFrame: self.view.bounds];
    [self.view addSubview: vc.view];
    [vc didMoveToParentViewController: self];
}

- (void)setUpToolbar {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(toggleToolbar:)];
    [self.view addGestureRecognizer: tapGesture];
    [self.view bringSubviewToFront: self.headerSafeAreaView];
    [self.view bringSubviewToFront: self.headerView];
    [self.view bringSubviewToFront: self.toolbar];
    [self.view bringSubviewToFront: self.pageSlider];
    self.headerSafeAreaView.alpha = 0.0;
    self.headerView.alpha = 0.0;
    self.toolbar.alpha = 0.0;
    self.pageSlider.alpha = 0.0;
    self.pageSlider.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;

    // スライダーの最小値と最大値を設定
    [self setUpPageSliderRange];
}

- (void)toggleToolbar:(UITapGestureRecognizer *)recognizer {
    if (self.headerSafeAreaView.alpha == 0.0) {
        [self showToolbar];
    } else {
        [self hideToolbar];
    }
}

- (void)showToolbar {
    [UIView animateWithDuration: 0.4 animations:^{
        self.headerSafeAreaView.alpha = 1.0;
        self.headerView.alpha = 1.0;
        self.toolbar.alpha = 1.0;
        self.pageSlider.alpha = 1.0;
    }];
}

@end
