//
//  WaterViewController.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/4/7.
//  Copyright © 2018年 微光星芒. All rights reserved.
//

#import "WaterViewController.h"
#import "WaterViewCell.h"
#import "ScanReusableHeadView.h"
#import "LabelsFlowLayout.h"

#import "CollectionReusableView.h"

@interface WaterViewController () <LabelsFlowLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *datasouce;
@end


@implementation WaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        CollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headView" forIndexPath:indexPath];
        
        /*
        NSString *title;
        if (indexPath.section == 0) {
            title = @"公司类型";
        }else if (indexPath.section == 1){
            title = @"险种";
        }
        headView.title = title;
        */
        return headView;
    }
      CollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headView" forIndexPath:indexPath];
    
    return headView;
}

/*
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 100);
}
*/


//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _datasouce.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WaterViewCell" forIndexPath:indexPath];
    
    cell.titleLab.text = _datasouce[indexPath.item];
    return cell;
}


//设置每个item的尺寸

/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 20);
}
*/


- (CGFloat)waterFlowLayout:(LabelsFlowLayout *)layout widthAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = _datasouce[indexPath.item];
    
    CGSize size = CGSizeMake(SCREEN_WIDTH - layout.sectionInset.left - layout.sectionInset.right,CGFLOAT_MAX);
    CGRect textRect = [title
                       boundingRectWithSize:size
                       options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                       context:nil];
    CGFloat width = textRect.size.width + 2 *15;
    return width;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)initUI{
    _datasouce = [@[@"运费险",@"保险公司(车险)",@"保险公司(人寿)",@"保险公司(财产险)",@"保险代理公司(幼儿保)",@"评估公司",@"律师行业公司",@"风险控制协会"]mutableCopy];

    
    LabelsFlowLayout *layout = [[LabelsFlowLayout alloc]init];
    layout.delegate = self;
    layout.rowHeight = 30;
    layout.lineDistance = 10;
    layout.InteritemDistance = 10;
    layout.collectionViewInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    layout.headViewHeight = 100;
        
    
    [_collectionView registerNib:[UINib nibWithNibName:@"WaterViewCell" bundle:nil] forCellWithReuseIdentifier:@"WaterViewCell"];

    [_collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];

    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    

    _collectionView.collectionViewLayout = layout;
    
}

@end
