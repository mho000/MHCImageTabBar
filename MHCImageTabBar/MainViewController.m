
#import "MainViewController.h"

@implementation MainViewController

+(instancetype)mainViewControllerWithStoryboardName:(NSString *)storyboard imageName:(NSString *)image {
    return [[MainViewController alloc] initWithStoryboardName:storyboard imageName: image];
}

-(instancetype)initWithStoryboardName:(NSString *)storyboard imageName:(NSString *)image {
    self = [super init];
    if (self) {
        self.storyboardName = storyboard;
        self.imageName = image;
    }
    return self;
}

@end