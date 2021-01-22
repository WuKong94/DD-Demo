//
//  BGScrollView.h
//  ddDemo
//
//  Created by 孙武东 on 2021/1/19.
//

#import <UIKit/UIKit.h>

@class BGScrollView;
NS_ASSUME_NONNULL_BEGIN

@protocol BGScrollViewDelegate <NSObject>

- (BOOL)shouldTouchPulleyScrollView:(BGScrollView *)scrollView point:(CGPoint)point;

- (UIView *)viewToReceiveTouch:(BGScrollView *)scrollView point:(CGPoint)point;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface BGScrollView : UIScrollView

@property (nullable, nonatomic, weak) id<BGScrollViewDelegate> touchDelegate;

@property (nonatomic, strong)UIView *touchView;

@end

NS_ASSUME_NONNULL_END
