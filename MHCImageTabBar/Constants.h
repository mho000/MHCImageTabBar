
#import <UIKit/UIkit.h>
#import "MainViewController.h"

#ifndef Constants_h
#define Constants_h

//NSString * const AfeCollectionViewDSMoveFromKey = @"From";

@implementation UIColor (MHCImageTabBarExtension)

+(UIColor *)tabBarBackgroundColor {
    return [UIColor colorWithRed: 0.92 green: 0.96 blue: 0.95 alpha: 1];
}

+(UIColor *)tabBarSeparatorColor {
    return [UIColor colorWithRed: 0.45 green: 0.77 blue: 0.72 alpha: 1];
}

+(UIColor *)tabBarSelectedItemColor {
    return [UIColor colorWithRed: 0.38 green: 0.73 blue: 0.69 alpha: 1];
}

+(UIColor *)tabBarUnselectedItemColor {
    return [UIColor colorWithRed: 0.65 green: 0.74 blue: 0.71 alpha: 1];
}

@end

BOOL const kRTLTabBar = NO;

#define kMainViewControllers @[ \
    [MainViewController mainViewControllerWithStoryboardName:@"Main1" imageName:@"one"],    \
    [MainViewController mainViewControllerWithStoryboardName:@"Main2" imageName:@"two"],    \
    [MainViewController mainViewControllerWithStoryboardName:@"Main3" imageName:@"three"],  \
    [MainViewController mainViewControllerWithStoryboardName:@"Main4" imageName:@"four"]]    \

#endif /* Constants_h */
