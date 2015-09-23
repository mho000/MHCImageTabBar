
#import <UIKit/UIKit.h>

@interface MHCImageTabBarViewController : UIViewController

@property (nonatomic, strong, readonly) NSArray * viewControllers;
@property (nonatomic) NSInteger selectedViewControllerIndex;

@end
