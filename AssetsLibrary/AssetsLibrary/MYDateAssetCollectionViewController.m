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

@synthesize dateAssets = dateAssets_;
@synthesize allAssets = allAssets_;
@synthesize sections = sections_;

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
	// Do any additional setup after loading the view.
    [self setupAssetsLibrary];
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}

- (void)setupAssetsLibrary{
    self.allAssets = [NSMutableArray array];
    self.sections = [NSMutableDictionary array];
    //    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    ALAssetsGroupType assetsGroupType = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    
    ALAssetsGroupEnumerationResultsBlock groupResultBlock= ^(ALAsset *asset, NSUInteger index, BOOL *stop){
//        [assetList addObject:@{@0 : asset, @1 : [asset valueForProperty:ALAssetPropertyDate]}];
        NSLog(@"%@",asset);
        if ( asset ){
            [self.allAssets addObject:@{@0 : asset, @1:[asset valueForProperty:ALAssetPropertyDate]}];
        }
    };
    
    NSComparator comparetor = ^NSComparisonResult(id obj1, id obj2){
        NSDate *datea = obj1[@1];
        NSDate *dateb = obj2[@1];
        return [dateb compare:datea];
    };
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    
    ALAssetsLibraryGroupsEnumerationResultsBlock resultBlock = ^(ALAssetsGroup *assetsGroup, BOOL *stop) {
        NSLog(@"AssetsGroup : %@", assetsGroup);
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [assetsGroup setAssetsFilter:onlyPhotosFilter];
        if (assetsGroup) {
            if ( [assetsGroup numberOfAssets] > 0 ){
                [assetsGroup enumerateAssetsUsingBlock:groupResultBlock];
            }
        } else {
            // sort
            [self.allAssets sortWithOptions:NSSortConcurrent usingComparator:comparetor];
//            if ( self.dateAssets == nil ){
//                self.dateAssets = [[NSMutableDictionary alloc] init];
//            }
//            for (NSDictionary *asset in self.allAssets) {
//                NSString *assetDate = [formatter stringFromDate:asset[@1]];
//                NSLog(@"%@",asset);
//                if ( ![self.dateAssets objectForKey:assetDate] ){
//                    [self.dateAssets setObject:assetDate forKey:asset[@0]];
//                } else {
//                    [[self.dateAssets objectForKey:assetDate] addObject:asset[@0]];
//                }
//            }
            for (NSDictionary *asset in self.allAssets) {
                NSString *assetDate = [formatter stringFromDate:asset[@1]];
                if ( ![self.sections objectForKey:assetDate] ){
                    [self.sections setObject:@1 forKey:assetDate];
                } else {
                    [self.sections setObject:@([self.sections[assetDate] intValue]+1) forKey:assetDate];
                }
                
                
            }
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
    return [self.sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSInteger count;
//    NSInteger i = 0;
//    for (NSArray *dateAsset in [self.dateAssets allValues]) {
//        if ( i == section ){
//            count = [dateAsset count];
//            break;
//        }
//        i++;
//    }
//    NSInteger count;
//    NSInteger i = 0;
//    for (i = 0; i < [self.sections count]; i++ ){
//        if ( i == section ){
//            count = self.sections[
//        }
//    }
    return 3;
}

// Method to create cell at index path
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell"];// forIndexPath:indexPath];
    // UICollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionViewcell" forIndexPath:indexPath];
    
    static NSString      *cellID = @"UICollectionViewCell";
    UICollectionViewCell *cell   = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
//    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
//    ALAsset *asset;
//    NSInteger i = 0;
//    for (NSArray *dateAsset in [self.dateAssets allValues]) {
//        if ( i == indexPath.section){
//            asset = dateAsset[indexPath.row];
//            break;
//        }
//        i++;
//    }
    ALAsset *asset = [self.allAssets objectAtIndex:indexPath.row];
    UIImage *img   = [UIImage imageWithCGImage:[asset thumbnail]];
    
    UIImageView *imgView = [[UIImageView alloc] init]; // [[UIImageView alloc] initWithImage:[[self.assets objectAtIndex:indexPath.section] objectAtIndex:indexPath.item]];
    [imgView setImage:img];
    imgView.frame = CGRectMake(0, 0, 55, 55);//self.imageFrame;//CGRectMake(0.0, 0.0, 96.0, 72.0);
    
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
