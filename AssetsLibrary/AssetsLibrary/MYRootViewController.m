//
//  MYRootViewController.m
//  AssetsLibrary
//
//  Created by Mika Yamamoto on 2014/02/10.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import "MYRootViewController.h"
#import "MYAssetsGroupViewController.h"
#import "MYDateAssetCollectionViewController.h"

@interface MYRootViewController ()

@end

@implementation MYRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor redColor]];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
//    [self performSelector:@selector(setAssetsGroupViewController:) withObject:nil afterDelay:0];
    [self performSelector:@selector(setDateAsssetCollectionViewController:) withObject:nil afterDelay:0];
}

- (void)setAssetsGroupViewController:(id)sender
{
    MYAssetsGroupViewController *assetsGroupVC = [[MYAssetsGroupViewController alloc] initWithStyle:UITableViewStylePlain];
    //    [self.navigationController pushViewController:assetsGroupViewController animated:NO];
    //    [assetsGroupViewController release];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:assetsGroupVC];
    NSLog(@"%@", assetsGroupVC.navigationController);
    [self.view addSubview:navigation.view];
    //    [navigation release];
    //    [assetsGroupViewController release];
}

- (void)setDateAsssetCollectionViewController:(id)sender
{
    CGRect imageFrame = CGRectMake(0, 0, 55, 55);
    
    // CollectionView cellの設定
    UICollectionViewFlowLayout *layout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    
    layout.itemSize                = imageFrame.size;          // CGSizeMake(50, 50); // セルのサイズ
    layout.headerReferenceSize     = CGSizeMake(0, 0);              // セクションごとのヘッダーのサイズ
    layout.footerReferenceSize     = CGSizeMake(0, 0);              // セクションごとのフッターのサイズ
    layout.minimumLineSpacing      = 5.0;                           // 行ごとのスペースの最小値
    layout.minimumInteritemSpacing = 5.0;                           // アイテムごとのスペースの最小値
    layout.sectionInset            = UIEdgeInsetsMake(8, 8, 8, 8);  // セクションの外枠のスペース
    
    MYDateAssetCollectionViewController *dateAssetCVC = [[MYDateAssetCollectionViewController alloc] initWithCollectionViewLayout:layout];
    [self.view addSubview:dateAssetCVC.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
