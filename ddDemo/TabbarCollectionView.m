//
//  TabbarCollectionView.m
//  ddDemo
//
//  Created by 孙武东 on 2021/1/15.
//

#import "TabbarCollectionView.h"
#import "TabbarItem.h"
#import "TabbarhHeaderView.h"

@interface TabbarCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSArray *items;

@end

@implementation TabbarCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;

    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate   = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        self.scrollEnabled = NO;
        self.items = @[@[@{@"title":@"消息",@"icon":@"message"},@{@"title":@"文档",@"icon":@"Document"},@{@"title":@"应用",@"icon":@"application"},@{@"title":@"通讯录",@"icon":@"tongxunlu"},@{@"title":@"我的",@"icon":@"wode"}],@[@{@"title":@"消息",@"icon":@"message"},@{@"title":@"文档",@"icon":@"Document"},@{@"title":@"应用",@"icon":@"application"},@{@"title":@"通讯录",@"icon":@"tongxunlu"},@{@"title":@"我的",@"icon":@"wode"},@{@"title":@"消息",@"icon":@"message"},@{@"title":@"文档",@"icon":@"Document"},@{@"title":@"应用",@"icon":@"application"},@{@"title":@"通讯录",@"icon":@"tongxunlu"},@{@"title":@"我的",@"icon":@"wode"}]];
        
        [self registerNib:[UINib nibWithNibName:@"TabbarItem" bundle:nil] forCellWithReuseIdentifier:@"TabbarItem"];
        [self registerNib:[UINib nibWithNibName:@"TabbarhHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TabbarhHeaderView"];
    }
    return self;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TabbarItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"TabbarItem" forIndexPath:indexPath];
    item.icon.image = [UIImage imageNamed:self.items[indexPath.section][indexPath.row][@"icon"]];
    item.titlel.text = self.items[indexPath.section][indexPath.row][@"title"];
    return item;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TabbarhHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"TabbarhHeaderView" forIndexPath:indexPath];
        header.firstLine.hidden = indexPath.section != 0;
        header.secondLine.hidden = indexPath.section == 0;
        return header;
    }else{
        return nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.tabBarDelegate respondsToSelector:@selector(wdTabBar:selectIndex:)]) {
        [self.tabBarDelegate wdTabBar:self selectIndex:indexPath];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.items.count;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.items[section] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width / 5, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width,20);
}



@end
