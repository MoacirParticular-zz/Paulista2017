//
//  Artilharia_Celula.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "Artilharia_Celula.h"

@implementation Artilharia_Celula
@synthesize posicao;
@synthesize numeroGols;
@synthesize nmArtilheiro;
@synthesize imgTimeArtilheiro;
@synthesize bgColor = _bgColor;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, _bgColor.CGColor);
    CGContextAddRect(context, rect);
    CGContextFillPath(context);
    CGContextSaveGState(context);
}

@end
