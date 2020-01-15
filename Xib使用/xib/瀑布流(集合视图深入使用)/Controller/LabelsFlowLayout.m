//
//  LabelsFlowLayout.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/4/11.
//  Copyright © 2018年 微光星芒. All rights reserved.
//

#import "LabelsFlowLayout.h"

@interface LabelsFlowLayout ()

@property (strong, nonatomic) NSMutableDictionary *cellLayoutInfo;//保存cell的布局
@property (strong, nonatomic) NSMutableDictionary *headLayoutInfo;//保存头视图的布局
@property (strong, nonatomic) NSMutableDictionary *footLayoutInfo;//保存尾视图的布局

@property (assign, nonatomic) CGFloat startY;//记录开始的Y
@property (strong, nonatomic) NSMutableDictionary *maxYForColumn;//记录瀑布流每列最下面那个cell的底部y值


@property (strong, nonatomic) NSMutableArray *framesArray; //记录每个cell的frame

@end

@implementation LabelsFlowLayout

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        //行间距
        self.lineDistance = 10;
        
        //列间距
        self.InteritemDistance = 10;
        
        _headViewHeight = 0;
        _footViewHeight = 0;
        self.startY = 0;
        self.maxYForColumn = [NSMutableDictionary dictionary];

        self.cellLayoutInfo = [NSMutableDictionary dictionary];
        self.headLayoutInfo = [NSMutableDictionary dictionary];
        self.footLayoutInfo = [NSMutableDictionary dictionary];
        self.framesArray = [NSMutableArray array];
    }
    return self;
}

//准备布局
- (void)prepareLayout{
    
    [super prepareLayout];
    
    //重新布局需要清空
    [self.cellLayoutInfo removeAllObjects];
    [self.headLayoutInfo removeAllObjects];
    [self.footLayoutInfo removeAllObjects];
    [self.maxYForColumn removeAllObjects];
    [self.framesArray removeAllObjects];
    self.startY = 0;
    
    self.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, _headViewHeight);
    
    CGFloat sectionCount =  self.collectionView.numberOfSections;
    
    for (int section = 0; section < sectionCount; section ++) {
        
        //存储headView属性
        NSIndexPath *supplementaryViewIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        
        //头视图高度不为0,且根据代理方法能取得对应的头视图 才进行相应的布局
        if (_headViewHeight > 0 && [self.collectionView.dataSource  respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]) {
            
         
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:UICollectionElementKindSectionHeader withIndexPath:supplementaryViewIndexPath];
            //设置这个布局的frame
            attribute.frame = CGRectMake(0, self.startY, SCREEN_WIDTH, _headViewHeight);
            
            //保存这个布局信息
        
            self.headLayoutInfo[supplementaryViewIndexPath] = attribute;
            
            //得到下一个布局开始的Y值
            self.startY = self.startY + _headViewHeight + _collectionViewInsets.top;
            
        }else{
            
            //没有头部视图, 只有collectionview的上间距
            self.startY = self.startY + _collectionViewInsets.top;
        }
        
        //开始计算cell的布局
        
        //每一个section中,有多少个cell
        
        NSInteger cellCount = [self.collectionView numberOfItemsInSection:section];
        
        //计算每个cell的布局
        
        NSMutableArray *currentSectionFrames = [NSMutableArray arrayWithCapacity:sectionCount];
        [_framesArray addObject:currentSectionFrames];
        
        for (int row = 0; row < cellCount; row ++) {
            NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
            
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:cellIndexPath];
            
            CGFloat x = _collectionViewInsets.left;
            CGFloat y = self.startY;
            
            //判断获得前一个cell的frame
            
            NSInteger preRow = row - 1;
            
            //从row = 1, 先获得前一个cell的frame, 计算当前cell的frame
            if (preRow >= 0 && currentSectionFrames.count > preRow) {
                CGRect preCellFrame = [currentSectionFrames[preRow] CGRectValue];
                x = preCellFrame.origin.x + preCellFrame.size.width + self.InteritemDistance;
                y = preCellFrame.origin.y;
            }
            CGFloat currentWidth = [self.delegate waterFlowLayout:self widthAtIndexPath:cellIndexPath];
            
            //保证单个cell不超过最大宽度
            CGFloat maxCellWidth = self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - self.collectionView.contentInset.left - self.collectionView.contentInset.right;
            
            //获得当前cell的宽度
            currentWidth = MIN(currentWidth, maxCellWidth);
            
            //当前cell的最右侧有没有超出屏幕
            if (x + currentWidth > self.collectionView.frame.size.width - self.sectionInset.right - self.collectionView.contentInset.right) {
                //超出范围 换行
                x = self.sectionInset.left;
                y  = self.startY + self.rowHeight + self.lineDistance;
            }
            
            // 保存这个cell的属性
            CGRect currentCellFrame = CGRectMake(x, y, currentWidth, _rowHeight);
            [currentSectionFrames addObject:[NSValue valueWithCGRect:currentCellFrame]];
            
            //保存这个cell的布局
            attribute.frame = CGRectMake(x, y, currentWidth, _rowHeight);
            //保留cell的布局对象
            self.cellLayoutInfo[cellIndexPath] = attribute;
            
            self.startY = y;
            
        }
        
        //存储footView属性
        //尾视图的高度不为0并且根据代理方法能取到对应的尾视图的时候，添加对应尾视图的布局对象
        if (_footViewHeight>0 && [self.collectionView.dataSource respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]) {
            
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:supplementaryViewIndexPath];
            
            attribute.frame = CGRectMake(0, self.startY, self.collectionView.frame.size.width, _footViewHeight);
            self.footLayoutInfo[supplementaryViewIndexPath] = attribute;
            self.startY = self.startY + _footViewHeight;
        }
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray array];
    
    //添加当前屏幕可见的头视图的布局
    [self.headLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attribute, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [allAttributes addObject:attribute];
        }
    }];
    
    //添加当前屏幕可见的cell的布局
    [self.cellLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attribute, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [allAttributes addObject:attribute];
        }
    }];
    
 
    
    //添加当前屏幕可见的尾部的布局
    [self.footLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attribute, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [allAttributes addObject:attribute];
        }
    }];
    
    return allAttributes;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    
    CGRect oldBounds = self.collectionView.bounds;
    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
        return YES;
    }
    return NO;
    
    //
    //    return YES;
}

#pragma mark - CollectionView的滚动范围
//step2
- (CGSize)collectionViewContentSize
{
    //support set collectionview's contentInset
return CGSizeMake(self.collectionView.frame.size.width, MAX(self.startY, self.collectionView.frame.size.height));
}

//插入cell的时候系统会调用改方法
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = self.cellLayoutInfo[indexPath];
    return attribute;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = nil;
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        attribute = self.headLayoutInfo[indexPath];
    }else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]){
        attribute = self.footLayoutInfo[indexPath];
    }
    return attribute;
}





@end
