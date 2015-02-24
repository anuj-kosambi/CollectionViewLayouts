//
//  CollectionController.m
//  CollectionViewCircleLayout
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionController.h"
#import "CollectionAlbumLayout.h"

@interface CollectionController ()

@end

@implementation CollectionController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;

    // Register cell classes
    [self.collectionView registerClass:[CollectionAlbumCell class] forCellWithReuseIdentifier:AlbumCellResuseIdentifier];
    [self.collectionView setBackgroundColor:[UIColor blackColor]];
    // Do any additional setup after loading the view.
    
    UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    [self.collectionView addGestureRecognizer:pinchRecognizer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender
{
    CollectionAlbumLayout *layout = (CollectionAlbumLayout*)self.collectionView.collectionViewLayout;
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        CGPoint initialPinchPoint = [sender locationInView:self.collectionView];
        NSIndexPath* pinchedCellPath = [self.collectionView indexPathForItemAtPoint:initialPinchPoint];
        layout.pinchedIndexPath = pinchedCellPath;
        
    }
    
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        layout.pinchScale = sender.scale;
    }
    
    else
    {
        [self.collectionView performBatchUpdates:^{
            layout.pinchedIndexPath = nil;
            layout.pinchScale = 1.0;
        } completion:nil];
    }
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
