//
//  Mais_Celula.h
//
//  Created by Moacir Ezequiel Lamego on 12/11/12.
//  Copyright (c) 2012 Mobiles App All rights reserved.
//

#import "Mais_Celula.h"

@implementation Mais_Celula
@synthesize icone, titulo;

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

@end
