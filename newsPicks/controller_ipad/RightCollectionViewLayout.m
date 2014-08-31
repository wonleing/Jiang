//
//  RightCollectionViewLayout.m
//  newsPicks
//
//  Created by dengqixiang on 14-8-31.
//  Copyright (c) 2014年 dengqixiang. All rights reserved.
//

#import "RightCollectionViewLayout.h"

#define ITEM_SIZE_WIDTH 70

#define ITEM_SIZE_HEIGHT 50
#define ITEM_X_OFFSET    50
#define ITEM_Y_OFFSET    150
#define ITEM_TOP_Reveal  1
@interface RightCollectionViewLayout()
@property (nonatomic, strong) NSDictionary *layoutAttributes;
// arrays to keep track of insert, delete index paths
@property (nonatomic, strong) NSMutableArray *deleteIndexPaths;
@property (nonatomic, strong) NSMutableArray *insertIndexPaths;
@property (nonatomic, strong) NSMutableArray *moveIndexPaths;
@end

@implementation RightCollectionViewLayout
- (instancetype)init {
    
    self = [super init];
    
    if (self) [self initLayout];
    
    return self;
}

- (void)initLayout {
    
    self.topReveal = ITEM_SIZE_HEIGHT*0.85;
    self.offsetY = ITEM_Y_OFFSET;
}

- (CGFloat) getTopReveal
{
    return self.topReveal;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    CGSize size = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height) ;
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
    float itemH = self.collectionView.bounds.size.height - self.offsetY+(_cellCount-1)*self.topReveal;
    self.itemSize = CGSizeMake(self.collectionViewContentSize.width, itemH);
    
    
    CGPoint contentOffset = self.collectionView.contentOffset;
    CGFloat deltaH = self.collectionViewContentSize.height-self.collectionView.bounds.size.height;
    CGFloat deltaContentOffset = contentOffset.y-self.collectionViewContentSize.height+self.collectionView.bounds.size.height;
    NSMutableDictionary *layoutAttributes = [NSMutableDictionary dictionary];
    UICollectionViewLayoutAttributes *preattributes = nil;
    // 计算cell排列的直线斜率
    CGFloat tanTheta = (self.offsetY+deltaH)/ITEM_X_OFFSET;
    //self.offsetX = self.collectionView.bounds.size.width/2;
    NSLog(@"deltaH = %f",deltaH);
    //NSLog(@"deltaContentOffset/tanTheta = %f",deltaContentOffset/tanTheta);
    //    NSLog(@"self.offsetX = %f",self.offsetX);
    NSLog(@"contentOffset = %f",contentOffset.y);
    for (NSInteger item = _cellCount-1; item>=0; --item)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        CGRect visibleRect;
        attributes.zIndex = indexPath.item;
        attributes.hidden = NO;
        CGFloat y = 0;
        CGFloat x = 0;
        visibleRect.size = self.itemSize;
        if (preattributes == nil)
        {
            y = self.offsetY+deltaH;//(_cellCount-1)*self.topReveal+deltaH;
            x = ITEM_X_OFFSET-(y)*ITEM_X_OFFSET/(self.offsetY+deltaH);
        }
        else
        {
            y = preattributes.frame.origin.y - self.topReveal;
            if(y<contentOffset.y+(item)*ITEM_TOP_Reveal)
            {
                y = contentOffset.y+(item)*ITEM_TOP_Reveal;
            }
            x = ITEM_X_OFFSET-(y)*ITEM_X_OFFSET/(self.offsetY+deltaH)+deltaContentOffset/tanTheta;
        }
        
        visibleRect.origin = CGPointMake(x, y);
        attributes.frame = visibleRect;
        
        preattributes = attributes;
        layoutAttributes[indexPath] = attributes;
    }
    self.layoutAttributes = layoutAttributes;
}

-(CGSize)collectionViewContentSize
{
    return [self collectionView].frame.size;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    //NSLog(@"new bounds = %@",NSStringFromCGRect(newBounds));
    return NO;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    return self.layoutAttributes[path];
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    [self.layoutAttributes enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *stop) {
        
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            
            [layoutAttributes addObject:attributes];
        }
    }];
    
    return layoutAttributes;
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    // Keep track of insert and delete index paths
    [super prepareForCollectionViewUpdates:updateItems];
    
    self.deleteIndexPaths = [NSMutableArray array];
    self.insertIndexPaths = [NSMutableArray array];
    self.moveIndexPaths = [NSMutableArray array];
    for (UICollectionViewUpdateItem *update in updateItems)
    {
        if (update.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
        }
        else if (update.updateAction == UICollectionUpdateActionInsert)
        {
            [self.insertIndexPaths addObject:update.indexPathAfterUpdate];
        }
        else if (update.updateAction == UICollectionUpdateActionMove)
        {
            [self.moveIndexPaths addObject:update.indexPathAfterUpdate];
        }
    }
}

- (void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    // release the insert and delete index paths
    self.deleteIndexPaths = nil;
    self.insertIndexPaths = nil;
}


// Note: name of method changed
// Also this gets called for all visible cells (not just the inserted ones) and
// even gets called when deleting cells!
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // Must call super
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    if ([self.insertIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on inserted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        attributes.alpha = 0.0;
    }
    
    return attributes;
}

// Note: name of method changed
// Also this gets called for all visible cells (not just the deleted ones) and
// even gets called when inserting cells!
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // So far, calling super hasn't been strictly necessary here, but leaving it in
    // for good measure
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    if ([self.deleteIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on deleted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        attributes.alpha = 0.0;
        attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    }
    
    return attributes;
}

@end
