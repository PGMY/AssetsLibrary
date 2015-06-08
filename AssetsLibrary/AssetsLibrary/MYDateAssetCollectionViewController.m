//
//  MYDateAssetCollectionViewController.m
//  AssetsLibrary
//
//  Created by PGMY on 2014/02/12.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import "MYDateAssetCollectionViewController.h"


#import <AssetsLibrary/AssetsLibrary.h>
#import "AssetsAccessor.h"
#import "MYCollectionHeaderView.h"

@interface MYDateAssetCollectionViewController ()

@end

@implementation MYDateAssetCollectionViewController

#define ASSET    @0
#define DATE     @1
#define DATE_STR @2

@synthesize sectionList = sectionList_;
@synthesize assetsData  = assetsData_;

- (void)dealloc{
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupAssetsLibrary];
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerClass:[MYCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}

/**
 *  AssetsLibrary
 */
- (void)setupAssetsLibrary
{
    NSMutableArray *allAssets = [[NSMutableArray alloc] init];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    self.sectionList = arr;
    [arr release];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    self.assetsData  = dic;
    [dic release];
    
    
    // Assetsのグループタイプ
    ALAssetsGroupType assetsGroupType = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    // アセットライブラリから取得したグループ内のアセットごとの処理
    ALAssetsGroupEnumerationResultsBlock groupResultBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset) {
            NSDate   *assetDate    = [asset valueForProperty:ALAssetPropertyDate];
            NSString *assetDateStr = [formatter stringFromDate:assetDate];
            [allAssets addObject:@{ ASSET: asset, DATE: assetDate, DATE_STR: assetDateStr }];
        }
//         NSLog((@"%s [Line %d] "), __PRETTY_FUNCTION__, __LINE__);
    };
    
    NSComparator comparetor = ^NSComparisonResult (id obj1, id obj2) {
        NSDate *datea = obj1[DATE];
        NSDate *dateb = obj2[DATE];
        
        return [dateb compare:datea];
    };
    
    
    // ライブラリからアセットグループを取得する処理
    ALAssetsLibraryGroupsEnumerationResultsBlock resultBlock = ^(ALAssetsGroup *assetsGroup, BOOL *stop) {
        //        NSLog(@"AssetsGroup : %@", assetsGroup);
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [assetsGroup setAssetsFilter:onlyPhotosFilter];
        if (assetsGroup) {
            if ([assetsGroup numberOfAssets] > 0) {
                [assetsGroup enumerateAssetsUsingBlock:groupResultBlock];
            }
        } else {
            // 全体sort
            [allAssets sortWithOptions:NSSortConcurrent usingComparator:comparetor];
            for (NSDictionary *asset in allAssets) {
                NSString *dateStr = asset[DATE_STR];
                if (self.assetsData[dateStr]) {   // 存在していたら
                    [self.assetsData[dateStr] addObject:asset[ASSET]];
                } else {
                    NSMutableArray *sectionArray = [[NSMutableArray alloc] init];
                    [sectionArray addObject:asset[ASSET]];
                    [self.assetsData setObject:sectionArray forKey:dateStr];
                    [sectionArray release];
                    [self.sectionList addObject:dateStr];
                }
            }
            [formatter release];
            [allAssets release];
            [self.collectionView reloadData];
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
    };

    [[[AssetsAccessor sharedInstance] assetsLibrary] enumerateGroupsWithTypes:assetsGroupType usingBlock:resultBlock failureBlock:failureBlock];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// -------------------------------------------------------------------------------------------------------------------
#pragma mark - CollectionView DataSource
// -------------------------------------------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.sectionList count]; // [self.assetsSection count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.assetsData[self.sectionList[section]] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MYCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:@"header"
                                                                                   forIndexPath:indexPath];
    
    headerView.title.text = self.sectionList[indexPath.section];
    [headerView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    return headerView;
}

// Method to create cell at index path
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString      *cellID = @"UICollectionViewCell";
    UICollectionViewCell *cell   = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    ALAsset *asset = self.assetsData[self.sectionList[indexPath.section]][indexPath.row];
    UIImage *img   = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]]; //thumbnail]];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView setImage:img];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    imgView.frame = CGRectMake(0, 0, 106, 70);
    imgView.backgroundColor = [UIColor blackColor];
    
    [cell addSubview:imgView];
    
    
    return cell;
}

// -------------------------------------------------------------------------------------------------------------------
#pragma mark - CollectionView Delegate
// -------------------------------------------------------------------------------------------------------------------

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // クリックされたらよばれる
    NSLog(@"Clicked %ld-%ld", indexPath.section, indexPath.row);
    
}

@end
