//
//  CollectionController.m
//  CollectionViewCircleLayout
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionController.h"
#import "CollectionDataSource.h"

@interface CollectionController ()

@end

@implementation CollectionController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[CollectionCircleCell class] forCellWithReuseIdentifier:CircleCellResuseIdentifier];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.collectionView setGestureRecognizers:@[tapRecognizer]];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    CGPoint touchPoint = [sender locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:touchPoint];
    CollectionDataSource *dataSource = self.collectionView.dataSource;
    if (indexPath) {
      dataSource.CellCount = dataSource.CellCount - 1;
        [self.collectionView performBatchUpdates:^{
          
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        } completion:nil];

    } else {
        dataSource.CellCount = dataSource.CellCount + 1;
        [self.collectionView performBatchUpdates:^{
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:dataSource.CellCount - 1  inSection:0];
            [self.collectionView insertItemsAtIndexPaths:@[newIndexPath]];
        } completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
