//
//  WaterFlowLayout.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/4/7.
//  Copyright © 2018年 微光星芒. All rights reserved.
//

#import "WaterFlowLayout.h"

static NSString *const kUICollectionHeadView = @"headView";

@interface WaterFlowLayout()

@property (nonatomic,strong) NSMutableDictionary *cellLayoutInfo; //保存cell的布局
@property (nonatomic,strong) NSMutableDictionary *headLayoutInfo; //保存头部视图的布局
@property (nonatomic,strong) NSMutableDictionary *footLayoutInfo; //保存尾部视图的布局
@property (nonatomic,assign) CGFloat startY; //记录开始的Y
@property (nonatomic,strong) NSMutableDictionary *maxYForColumn; //记录瀑布流每列最下面那个cell的底部Y值
@property (nonatomic,strong) NSMutableArray *shouldanimationary;//记录需要添加动画的NSIndexPath

@end

@implementation WaterFlowLayout
/*

//自定义布局难点: 布局里要实现每个通过itemSize属性设置item的尺寸

//预布局  所有的布局应该写在这里
- (void)prepareLayout{
    
}

//返回当前屏幕正在显示的视图(cell 头尾视图)的布局属性集合 (UICollectinViewLayoutAttributes  对象集合)
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return nil;
}

//根据indexPath取对应的UICollectionViewLayoutAttributes 这个是取值,需要重写,在移动深处的时候 系统会调用此方法 重新取UICollectionViewLayoutAttributes, 然后布局

//取当前indexPath的cell的UICollectionViewLayoutAttributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

//取当期indexPath的SupplementaryView的UICollectionViewLayoutAttributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
}

//返回当前contentSize
- (CGSize )collectionViewContentSize;

//是否重新布局
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;
*/




- (instancetype)init{
    self = [super init];
    if (self) {
        self.numberOfColumnes = 3;
        self.collectionViewInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _headViewHeight = 0;
        _footViewHeight = 0;
        self.startY = 0;
        
        self.maxYForColumn = [NSMutableDictionary dictionary];
        self.cellLayoutInfo = [NSMutableDictionary dictionary];
        self.shouldanimationary = [NSMutableArray array];
        self.headLayoutInfo = [NSMutableDictionary dictionary];
        self.footLayoutInfo = [NSMutableDictionary dictionary];
    }
    return self;
}

//预布局 所有的布局都在这里
- (void)prepareLayout{
    [super prepareLayout];

    //重新布局 清空之前布局数据
    [self.cellLayoutInfo removeAllObjects];
    [self.headLayoutInfo removeAllObjects];
    [self.footLayoutInfo removeAllObjects];
    [self.maxYForColumn removeAllObjects];
    self.startY = 0;

    //瀑布流是计算每一行cell的高度
    CGFloat viewWidth = self.collectionView.frame.size.width;
    //得到每一个item的宽度
    CGFloat itemWidth = (viewWidth - self.cellDistance * (self.numberOfColumnes + 1)/self.numberOfColumnes);
    
    //取到所有的section
    NSInteger sectionCount = [self.collectionView numberOfSections];
    
    for (int section = 0; section < sectionCount; section++) {
        //存储headView属性
        NSIndexPath *supplementaryViewIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        //当透视图的高度 > 0, 且头部视图存在
        if (_headViewHeight > 0 && [self.collectionView.dataSource respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
            //创建一个布局对象 存放headView的布局属性
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kUICollectionHeadView withIndexPath:supplementaryViewIndexPath];
        
            attribute.frame = CGRectMake(0, self.startY, self.collectionView.frame.size.width, _headViewHeight);
            //保存这个布局对相应
            self.headLayoutInfo[supplementaryViewIndexPath] = attribute;
            
            //更新Y值
            self.startY = self.startY + _headViewHeight + _collectionViewInsets.top;
        }else{
            //没有头部视图, 也要更新Y值
            self.startY = self.startY + _collectionViewInsets.top;
        }
        
        //将section第一排cell的frame的Y值进行设置; 保存了第一行cell,开始的Y值
        for (int i = 0; i < _numberOfColumnes; i ++) {
            self.maxYForColumn[@(i)] = @(self.startY);
        }
        
        //计算cell的布局
        
        //先获得section有多少个cell
        NSInteger rowsCount = [self.collectionView  numberOfItemsInSection:section];
        
        for (NSInteger row = 0; row < rowsCount; row ++) {
            NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
            
            UICollectionViewLayoutAttributes *atteibute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:cellIndexPath];
            
            //计算当前最短的一列,将当前cell加入(瀑布流是加载到最短的一列)
            
            //取出第一个值
            CGFloat y = [self.maxYForColumn[@(0)] floatValue];
            
            //得到最小值
            NSInteger currentRow = 0;
            for (int i = 0; i < _numberOfColumnes; i ++) {
                if ([self.maxYForColumn[@(i)] floatValue] < y) {
                    y = [self.maxYForColumn[@(i)] floatValue];
                    currentRow = i;
                }
            }
            
            //计算x值
            CGFloat x = self.cellDistance + (self.cellDistance + itemWidth) *currentRow;
            
            //根据代理获得当前cell的高度
            
            
        }
        
    }
}

















@end
