
#import "MHCImageTabBarViewController.h"
#import "Constants.h"

#pragma mark - helper

@interface UIView (MHAlignView)

-(void)mh_alignViews:(NSArray *)views firstAttribute:(NSLayoutAttribute)firstAtt secondAttribute:(NSLayoutAttribute)secondAtt;

@end

@implementation UIView (MHAlignView)

-(void)mh_alignViews:(NSArray *)views firstAttribute:(NSLayoutAttribute)firstAtt secondAttribute:(NSLayoutAttribute)secondAtt {
    
    if(views.count == 0) {
        return;
    }
    
    UIView * previousView = views.firstObject;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:previousView attribute:firstAtt relatedBy:NSLayoutRelationEqual toItem:self attribute:firstAtt multiplier:1 constant:0]];
    
    UIView * currentView;
    
    for (NSInteger i = 1; i < views.count; i++) {
        currentView = views[i];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:currentView attribute:firstAtt relatedBy:NSLayoutRelationEqual toItem:previousView attribute:secondAtt multiplier:1 constant:0]];
        previousView = currentView;
    }
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:previousView attribute:secondAtt relatedBy:NSLayoutRelationEqual toItem:self attribute:secondAtt multiplier:1 constant:0]];
}

@end

@interface MHCImageTabBarViewController ()

@property (strong, nonatomic) IBOutlet UIView *tabBar;
@property (strong, nonatomic) IBOutlet UIView *tabBarSeparator;

@property (nonatomic, strong) NSArray * imageViews;

@property (nonatomic, strong) UIViewController * selectedViewController;

@end

@implementation MHCImageTabBarViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        NSMutableArray * vcs = [NSMutableArray new];
        NSMutableArray * ivs = [NSMutableArray new];
        NSBundle * mainBundle = [NSBundle mainBundle];
        
        NSInteger i = 0;
        for (MainViewController * mvc in kMainViewControllers) {
            [vcs addObject:[[UIStoryboard storyboardWithName:mvc.storyboardName bundle:mainBundle] instantiateInitialViewController]];
            
            UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectZero];
            iv.contentMode = UIViewContentModeCenter;
            iv.tag = i;
            iv.image = [[UIImage imageNamed:mvc.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            iv.translatesAutoresizingMaskIntoConstraints = NO;
            [ivs addObject:iv];
            
            i++;
        }
        
        _viewControllers = [NSArray arrayWithArray:vcs];
        _imageViews = [NSArray arrayWithArray:ivs];
    }
    return self;
}

-(void)setSelectedViewControllerIndex:(NSInteger)selectedViewControllerIndex {
    
    [self.imageViews[_selectedViewControllerIndex] setTintColor:nil];
    
    _selectedViewControllerIndex = selectedViewControllerIndex;
    
    [self.imageViews[selectedViewControllerIndex] setTintColor:[UIColor tabBarSelectedItemColor]];
    
    [self switchToViewController:self.viewControllers[selectedViewControllerIndex]];
}

#pragma mark - setup

-(void)setup {
    [self addSubviews];
    [self setupConstraints];
    [self addGestureRecognizers];
    
    self.tabBar.tintColor = [UIColor tabBarUnselectedItemColor];
    self.tabBar.backgroundColor = [UIColor tabBarBackgroundColor];
    self.tabBarSeparator.backgroundColor = [UIColor tabBarSeparatorColor];
    self.tabBar.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
}

-(void)addSubviews {
    for (UIImageView * iv in self.imageViews) {
        [self.tabBar addSubview:iv];
    }
}

-(void)setupConstraints {
    [self setupImageViewsConstraints];
}

-(void)setupImageViewsConstraints {
    if(kRTLTabBar) {
        [self.tabBar mh_alignViews:self.imageViews firstAttribute:NSLayoutAttributeRight secondAttribute:NSLayoutAttributeLeft];
    } else {
        [self.tabBar mh_alignViews:self.imageViews firstAttribute:NSLayoutAttributeLeft secondAttribute:NSLayoutAttributeRight];
    }
    
    UIView * first = self.imageViews.firstObject;
    
    [self.tabBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[first]|" options:0 metrics:nil views:@{@"first": first}]];
    
    for (NSInteger i = 1; i < self.imageViews.count; i++) {
        UIView * v = self.imageViews[i];
        
        [self.tabBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v]|" options:0 metrics:nil views:@{@"v":v}]];
        [self.tabBar addConstraint:[NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:first attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    }
}

-(void)addGestureRecognizers {
    for (UIImageView * iv in self.imageViews) {
        iv.userInteractionEnabled = YES;
        [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerTapped:)]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
    self.selectedViewControllerIndex = 0;
}

#pragma mark - Actions

-(void)switchToViewController:(UIViewController *)toVC {
    [self.selectedViewController removeFromParentViewController];
    [self.selectedViewController.view removeFromSuperview];
    [self.selectedViewController didMoveToParentViewController:nil];
    
    [self addChildViewController:toVC];
    [self addChildView:toVC.view];
    [toVC didMoveToParentViewController:self];
    
    self.selectedViewController = toVC;
}

-(void)addChildView:(UIView *)aView {
    aView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:aView];
    
    NSDictionary * views = @{@"child": aView, @"tabBar": self.tabBar};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[child]|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[child][tabBar]" options:0 metrics:nil views:views]];
    
    [self.view layoutIfNeeded];
}

-(void)gestureRecognizerTapped:(UITapGestureRecognizer *)tgr {
    self.selectedViewControllerIndex = tgr.view.tag;
}

@end
