//
//  TabbarCollectionView.h
//  ddDemo
//
//  Created by 孙武东 on 2021/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WDTabBarDelegate <NSObject>

- (void)wdTabBar:(UICollectionView *)tabbar selectIndex:(NSIndexPath *)indexPath;

@end

@interface TabbarCollectionView : UICollectionView

@property (nullable, nonatomic, weak) id<WDTabBarDelegate> tabBarDelegate;

@end

NS_ASSUME_NONNULL_END
