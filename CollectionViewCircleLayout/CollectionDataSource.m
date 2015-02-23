//
//  CollectionDataSource.m
//  
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionDataSource.h"

@interface CollectionDataSource ()  {
    NSMutableArray *imageArray;
}

@end

@implementation CollectionDataSource

-(instancetype)init {
    self = [super init];
    if (self) {
        imageArray = [NSMutableArray array];
        for (int i = 1; i <= 20; i++) {
            [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]]];
        }
    }
    return self;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [imageArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCircleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CircleCellResuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = [imageArray objectAtIndex: (indexPath.row % [imageArray count])];
    return cell;
}

@end
