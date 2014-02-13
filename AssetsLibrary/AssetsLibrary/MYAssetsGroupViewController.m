//
//  MYAssetsGroupViewController.m
//  AssetsLibrary
//
//  Created by Mika Yamamoto on 2014/02/12.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import "MYAssetsGroupViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import "AssetsAccessor.h"
#import "MYAssetsGroupCollectionViewController.h"

@interface MYAssetsGroupViewController ()

@end

@implementation MYAssetsGroupViewController

@synthesize assetsGroups = assetsGroups_;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor blueColor]];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
     NSLog(@"%@", self.navigationController);
    
    [self setupAssetLibrary];
}

- (void)setupAssetLibrary
{
    self.assetsGroups = [NSMutableArray array];
    //    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    ALAssetsGroupType assetsGroupType = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    
    ALAssetsLibraryGroupsEnumerationResultsBlock resultBlock = ^(ALAssetsGroup *assetsGroup, BOOL *stop) {
        NSLog(@"AssetsGroup : %@", assetsGroup);
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [assetsGroup setAssetsFilter:onlyPhotosFilter];
        if (assetsGroup && [assetsGroup numberOfAssets] > 0) {
            [self.assetsGroups insertObject:assetsGroup atIndex:0];
        } else {
            [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.assetsGroups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    
    ALAssetsGroup *assetsGroup    = self.assetsGroups[indexPath.row];
    NSString      *groupName      = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    NSInteger      numberOfAssets = [assetsGroup numberOfAssets];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",  groupName, numberOfAssets];
    [cell.imageView setImage:[UIImage imageWithCGImage:[assetsGroup posterImage]]];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALAssetsGroup *assetsGroup = self.assetsGroups[indexPath.row];
    CGRect imageFrame = CGRectMake(0, 0, 55, 55);
    
    // CollectionView cellの設定
    UICollectionViewFlowLayout *layout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    
    layout.itemSize                = imageFrame.size;          // CGSizeMake(50, 50); // セルのサイズ
    layout.headerReferenceSize     = CGSizeMake(0, 0);              // セクションごとのヘッダーのサイズ
    layout.footerReferenceSize     = CGSizeMake(0, 0);              // セクションごとのフッターのサイズ
    layout.minimumLineSpacing      = 5.0;                           // 行ごとのスペースの最小値
    layout.minimumInteritemSpacing = 5.0;                           // アイテムごとのスペースの最小値
    layout.sectionInset            = UIEdgeInsetsMake(8, 8, 8, 8);  // セクションの外枠のスペース
    
    MYAssetsGroupCollectionViewController *assetsGroupCVC = [[MYAssetsGroupCollectionViewController alloc] initWithCollectionViewLayout:layout assetsGroup:assetsGroup];
    NSLog(@"%@", self.navigationController);
    [self.navigationController pushViewController:assetsGroupCVC animated:YES];
    [assetsGroupCVC release];
    //    MixiAssetsViewController *assetVC = [[MixiAssetsViewController alloc] initWithAssetsGroup:assetsGroup];
    //    [self.navigationController pushViewController:assetVC animated:YES];
}

@end
