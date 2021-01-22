//
//  TabbarItem.h
//  ddDemo
//
//  Created by 孙武东 on 2021/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabbarItem : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titlel;

@end

NS_ASSUME_NONNULL_END
