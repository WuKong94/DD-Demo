//
//  BGScrollView.m
//  ddDemo
//
//  Created by 孙武东 on 2021/1/19.
//

#import "BGScrollView.h"

#define kBottomViewHeight 230
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScrollOffset 50
#define kTabbarHeight (49 + 20 + [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom)
#define kBottomHeight [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom


@interface BGScrollView ()<UIScrollViewDelegate>

@end

@implementation BGScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        [self addSubview:self.touchView];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([self.touchDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.touchDelegate scrollViewDidScroll:scrollView];
    }
    
    self.touchView.alpha = scrollView.contentOffset.y > kScrollOffset ? 0.1 : (scrollView.contentOffset.y / kScrollOffset) * 0.1;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y > kScrollOffset) {
        [scrollView setContentOffset:CGPointMake(0, kBottomViewHeight - kTabbarHeight) animated:YES];
    }else{
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)dismissView{
    [self setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self.touchDelegate respondsToSelector:@selector(shouldTouchPulleyScrollView:point:)]) {
        if ([self.touchDelegate shouldTouchPulleyScrollView:self point:point]) {
            UIView *view = [self.touchDelegate viewToReceiveTouch:self point:point];
            CGPoint p = [view convertPoint:point fromView:self];
            return [view hitTest:p withEvent:event];
        }
    }
    return [super hitTest:point withEvent:event];
}

- (UIView *)touchView{
    if (!_touchView) {
        _touchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _touchView.backgroundColor = [UIColor blackColor];
        _touchView.alpha = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
        [_touchView addGestureRecognizer:tap];
        
    }
    return _touchView;
}

@end
