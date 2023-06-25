//
//  ANCComicViewerContainerViewController.m
//  Ancient
//
//  Created by Yuki Okudera on 2023/06/25.
//

#import "ANCComicViewerContainerViewController.h"
#import "ANCComicViewerViewController.h"

@interface ANCComicViewerContainerViewController ()

@property (weak, nonatomic) IBOutlet UIView *headerSafeAreaView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousButton;

- (void)addComicViewerView;
- (void)setUpToolbar;
- (void)toggleToolbar:(UITapGestureRecognizer *)recognizer;
- (void)showToolbar;
- (void)hideToolbar;

@end

@implementation ANCComicViewerContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addComicViewerView];
    [self setUpToolbar];
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

- (void)addComicViewerView {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"ANCComicViewerViewController" bundle: [NSBundle mainBundle]];
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
    self.headerSafeAreaView.alpha = 0.0;
    self.headerView.alpha = 0.0;
    self.toolbar.alpha = 0.0;
    self.titleLabel.text = @"作品タイトル";
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
    }];
}

- (void)hideToolbar {
    [UIView animateWithDuration: 0.4 animations:^{
        self.headerSafeAreaView.alpha = 0.0;
        self.headerView.alpha = 0.0;
        self.toolbar.alpha = 0.0;
    }];
}

@end
