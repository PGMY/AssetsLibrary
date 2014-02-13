//
//  MYDateAssetCollectionViewController.m
//  AssetsLibrary
//
//  Created by Mika Yamamoto on 2014/02/12.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import "MYDateAssetCollectionViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import "AssetsAccessor.h"

@interface MYDateAssetCollectionViewController ()

@end

@implementation MYDateAssetCollectionViewController

#define ASSET    @0
#define DATE     @1
#define DATE_STR @2
#define COUNT @3
#define INDEX @4

@synthesize allAssets     = allAssets_;
@synthesize assetsSection = assetsSection_;

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
}

/**
 *  AssetsLibrary
 */
- (void)setupAssetsLibrary
{
    self.allAssets     = [[NSMutableArray alloc] init];
    self.assetsSection = [[NSMutableArray alloc] init];
    
    // Assetsのグループタイプ
    ALAssetsGroupType assetsGroupType = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    // アセットライブラリから取得したグループ内のアセットごとの処理
    ALAssetsGroupEnumerationResultsBlock groupResultBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset) {
            NSDate *assetDate = [asset valueForProperty:ALAssetPropertyDate];
            NSString *assetDateStr =[formatter stringFromDate:assetDate];
//            if ( !self.assetsSection[assetDateStr] ){
//                [self.assetsSection setObject:@1 forKey:assetDateStr];
//            } else {
//                NSInteger count = [self.assetsSection[assetDateStr] intValue];
//                count++;
//                [self.assetsSection setObject:@(count) forKey:assetDateStr];
//            }
            [self.allAssets addObject:@{ ASSET: asset, DATE: assetDate, DATE_STR: assetDateStr}];
        }
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
            [self.allAssets sortWithOptions:NSSortConcurrent usingComparator:comparetor];
            
            
//            int index = 0;
//            for (NSDictionary *asset in allAssets) {
//                NSString *dateStr = asset[DATE_STR];
//                
            
//                if ( !self.assetsSection[dateStr] ){
//                    [assetsSection setObject:@{COUNT: @1, DATE_STR:@(index), ASSET:asset} forKey:dateStr];
//                    index++;
//                } else {
//                    NSInteger count = [self.assetsSection[dateStr][COUNT] intValue];
//                    NSInteger assetIndex = [self.assetsSection[dateStr][INDEX] intValue];
//                    count++;
//                    [self.assetsSection setObject:@{COUNT: @1, INDEX:@(assetIndex)} forKey:dateStr];
//                }
//            }
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
    return 1;//[self.assetsSection count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

// Method to create cell at index path
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell"];// forIndexPath:indexPath];
    // UICollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionViewcell" forIndexPath:indexPath];
    
    static NSString      *cellID = @"UICollectionViewCell";
    UICollectionViewCell *cell   = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    
    ALAsset *asset = [self.allAssets objectAtIndex:(indexPath.row)][ASSET];
    UIImage *img   = [UIImage imageWithCGImage:[asset thumbnail]];
    
    UIImageView *imgView = [[UIImageView alloc] init]; // [[UIImageView alloc] initWithImage:[[self.assets objectAtIndex:indexPath.section] objectAtIndex:indexPath.item]];
    [imgView setImage:img];
    imgView.frame = CGRectMake(0, 0, 55, 55); // self.imageFrame;//CGRectMake(0.0, 0.0, 96.0, 72.0);
    
    // cellにimgViewをセット
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
