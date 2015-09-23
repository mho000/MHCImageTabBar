
#import <Foundation/Foundation.h>

@interface MainViewController : NSObject

@property (nonatomic, strong) NSString * storyboardName;
@property (nonatomic, strong) NSString * imageName;

+(instancetype)mainViewControllerWithStoryboardName:(NSString *)storyboard imageName:(NSString *)image;
-(instancetype)initWithStoryboardName:(NSString *)storyboard imageName:(NSString *)image;

@end