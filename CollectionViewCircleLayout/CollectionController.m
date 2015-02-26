//
//  CollectionController.m
//  CollectionViewCircleLayout
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionController.h"
#import "CollectionAlbumLayout.h"
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
    [self.collectionView registerClass:[CollectionAlbumCell class] forCellWithReuseIdentifier:AlbumCellResuseIdentifier];
    [self.collectionView registerClass:[CollectionSupplementaryView class] forSupplementaryViewOfKind:@"Header" withReuseIdentifier:AlbumSupplyResuseIdentifier];
    [self.collectionView setBackgroundColor:[UIColor lightGrayColor]];
    UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    NSMutableArray *gArray = [[NSMutableArray alloc] initWithArray:self.collectionView.gestureRecognizers];
    [gArray addObject:gestureRecognizer];
    self.collectionView.gestureRecognizers = gArray;
    // Do any additional setup after loading the view.
}

- (void)handleLongPress:(UIPanGestureRecognizer *)sender{
    CollectionAlbumLayout  *layout = (CollectionAlbumLayout *)self.collectionView.collectionViewLayout;
    CollectionDataSource *collectionDataSource = self.collectionView.dataSource;
    CGPoint gesturePosition = [sender locationInView:self.collectionView];
    NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:gesturePosition];
    if (selectedIndexPath) {

        if (sender.state == UIGestureRecognizerStateBegan)
        {
            layout.selectedItem = selectedIndexPath;
            layout.gesturePoint = gesturePosition;
        }
        else if (sender.state == UIGestureRecognizerStateChanged)
        {
            layout.gesturePoint = gesturePosition;
            layout.hoverItem = [self.collectionView indexPathForItemAtPoint:gesturePosition];
            [layout invalidateLayout];
        }
        else
        {
            [self.collectionView performBatchUpdates:^
             {
                 layout.selectedItem = nil;
              
                 layout.gesturePoint = CGPointZero;
                 
             } completion:^(BOOL completion){
                 NSIndexPath *newIndexPath = [self.collectionView indexPathForItemAtPoint:gesturePosition];
                 [self.collectionView moveItemAtIndexPath:selectedIndexPath toIndexPath:newIndexPath];
                 NSMutableArray *imageArray = [collectionDataSource.dataSource objectForKey:ConvertIntToId(selectedIndexPath.section)];
                 UIImage *image = [imageArray objectAtIndex:selectedIndexPath.item];
                 [imageArray removeObjectAtIndex:selectedIndexPath.item];
                 [imageArray insertObject:image atIndex:newIndexPath.item];
                 [self.collectionView reloadData];
                layout.hoverItem = nil;
                 [layout invalidateLayout];
             }];
        }
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
