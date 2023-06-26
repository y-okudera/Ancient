//
//  UIApplication+ANCCurrentWindowInterfaceOrientation.m
//  Ancient
//
//  Created by Yuki Okudera on 2023/06/25.
//

#import "UIApplication+ANCCurrentWindowInterfaceOrientation.h"

@implementation UIApplication (ANCCurrentWindowInterfaceOrientation)

+ (UIInterfaceOrientation)currentInterfaceOrientation {
    UIInterfaceOrientation orientation = UIInterfaceOrientationUnknown;
    UIScene *scene = [[[[UIApplication sharedApplication] connectedScenes] allObjects] firstObject];
    if ([scene.delegate conformsToProtocol:@protocol(UIWindowSceneDelegate)]) {
        UIWindow *window = [(id <UIWindowSceneDelegate>)scene.delegate window];
        orientation = [window.windowScene interfaceOrientation];
    }
    return orientation;
}
@end
