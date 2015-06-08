//
//  MYAssetsGroupCollectionViewController.m
//  AssetsLibrary
//
//  Created by PGMY on 2014/02/12.
//  Copyright (c) 2014年 PGMY. All rights reserved.
//

#import "MYAssetsGroupCollectionViewController.h"

#import "AssetsAccessor.h"

@interface MYAssetsGroupCollectionViewController () {
    
    CGRect           imageFrame_;
}

@property (assign, nonatomic) CGRect           imageFrame;
@end

@implementation MYAssetsGroupCollectionViewController

@synthesize assetsGroup = assetsGroup_;
@synthesize assets = assets_;
@synthesize imageFrame           = imageFrame_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor yellowColor]];
    }
    
    return self;
}


- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout assetsGroup:(ALAssetsGroup*)assetsGroup
{
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.assetsGroup = assetsGroup;
        [self setupAssets:assetsGroup];
        self.imageFrame = CGRectMake(0, 0, 55, 55);
        
        [self.collectionView setBackgroundColor:[UIColor whiteColor]];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)setupAssets:(ALAssetsGroup *)assetsGroup
{
    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    
    if (!self.assets) {
        self.assets = [[NSMutableArray alloc] init];
    } else {
        [self.assets removeAllObjects];
    }
    
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [self.assets addObject:result];
        }
    };
    
    [assetsGroup enumerateAssetsUsingBlock:assetsEnumerationBlock];
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
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.assets count];
}

// Method to create cell at index path
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell"];// forIndexPath:indexPath];
    // UICollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionViewcell" forIndexPath:indexPath];
    
    static NSString      *cellID = @"UICollectionViewCell";
    UICollectionViewCell *cell   = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    UIImage *img   = [UIImage imageWithCGImage:[asset thumbnail]];
    
    UIImageView *imgView = [[UIImageView alloc] init]; // [[UIImageView alloc] initWithImage:[[self.assets objectAtIndex:indexPath.section] objectAtIndex:indexPath.item]];
    [imgView setImage:img];
    imgView.frame = self.imageFrame;//CGRectMake(0.0, 0.0, 96.0, 72.0);
    
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
