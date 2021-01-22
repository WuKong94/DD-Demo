//
//  FirstVC.m
//  ddDemo
//
//  Created by 孙武东 on 2021/1/15.
//

#import "FirstVC.h"
#import "TabbarCollectionView.h"
#import "BGScrollView.h"

#import "MessageVC.h"
#import "DocumentVC.h"
#import "ApplicationVC.h"
#import "AddressBookVC.h"
#import "MineVC.h"

#define kBottomViewHeight 230
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScrollOffset 50
#define kTabbarHeight (49 + 20 + [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom)
#define kBottomHeight [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom

@interface FirstVC ()<BGScrollViewDelegate,WDTabBarDelegate>

@property (nonatomic, strong)TabbarCollectionView *tabbar;
@property (nonatomic, strong)BGScrollView *scrollView;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UIView *contentView;

@property (nonatomic, strong)NSArray *vcArray;
@property (nonatomic, strong)NSMutableDictionary *vcMap;

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.contentView];
    
    self.vcArray = @[[MessageVC class],[DocumentVC class],[ApplicationVC class],[AddressBookVC class],[MineVC class]];
    
    [self selectTabBarIndex:0];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.tabbar];


    if (kBottomHeight > 0) {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenHeight - kBottomHeight, kScreenWidth, kBottomHeight)];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bottomView];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)selectTabBarIndex:(NSInteger)index{
    
    if (index >= self.vcArray.count) {
        return;
    }
    
    NSString *vcName = self.vcArray[index];
    
    if ([[self.vcMap allKeys] containsObject:vcName]) {
        
        UIViewController *vc = self.vcMap[vcName];
        
        [self.contentView bringSubviewToFront:vc.view];
        
    }else{
        UIViewController *vc = [[self.vcArray[index] alloc] init];
        [self addChildViewController:vc];
        [self.contentView addSubview:vc.view];
        
        [self.vcMap setValue:vc forKey:NSStringFromClass(self.vcArray[index])];
    }
    
    
}

- (BOOL)shouldTouchPulleyScrollView:(BGScrollView *)scrollView point:(CGPoint)point{
    CGPoint convertPoint = [self.tabbar convertPoint:point fromView:scrollView];
    return !CGRectContainsPoint(self.tabbar.bounds, convertPoint);
}

- (UIView *)viewToReceiveTouch:(BGScrollView *)scrollView point:(CGPoint)point{
    if (self.scrollView.touchView.alpha >= 0.1) {
        return self.scrollView.touchView;
    }
    return self.contentView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.tabbar.layer.cornerRadius = scrollView.contentOffset.y > kScrollOffset ? 8 : 0;
}

- (void)wdTabBar:(UICollectionView *)tabbar selectIndex:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        [self selectTabBarIndex:indexPath.row];

        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"item被点击" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];

        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

- (TabbarCollectionView *)tabbar{
    if (!_tabbar) {
        _tabbar = [[TabbarCollectionView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kTabbarHeight, kScreenWidth, kBottomViewHeight)];
        _tabbar.tabBarDelegate = self;
    }
    return _tabbar;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[BGScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _scrollView.bounces = NO;
        _scrollView.touchDelegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        [_scrollView setContentSize:CGSizeMake(kScreenWidth, kScreenHeight + kBottomViewHeight - kTabbarHeight)];
    }
    return _scrollView;
}

- (NSMutableDictionary *)vcMap{
    if (!_vcMap) {
        _vcMap = [NSMutableDictionary dictionary];
    }
    return _vcMap;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
