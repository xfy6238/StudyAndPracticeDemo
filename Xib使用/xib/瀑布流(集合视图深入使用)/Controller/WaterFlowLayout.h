//
//  WaterFlowLayout.h
//  Xib使用
//
//  Created by 微光星芒 on 2018/4/7.
//  Copyright © 2018年 微光星芒. All rights reserved.
//

#import <UIKit/UIKit.h>


//代理方法中用到了 WaterFlowLayout , 但这个时候,它还没有被声明, 用class先声明;
@class WaterFlowLayout;

@protocol WaterFlowLayoutDelegate <NSObject>

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WaterFlowLayout *)layout heightOfItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

@end

@interface WaterFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) NSInteger numberOfColumnes; //瀑布流几列
@property (nonatomic,assign) CGFloat cellDistance; //cell之间的间距

@property (nonatomic,assign) UIEdgeInsets collectionViewInsets;

@property (nonatomic,assign) CGFloat headViewHeight; //头部视图高度

@property (nonatomic,assign) CGFloat footViewHeight; //尾部视图高度

@property (nonatomic,weak) id<WaterFlowLayoutDelegate>delegate;

@end
