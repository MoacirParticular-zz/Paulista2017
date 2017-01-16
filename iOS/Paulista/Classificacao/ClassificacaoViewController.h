//
//  ClassificacaoViewController.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassificacaoCallMethods.h"
#import "DAOPiratini.h"
#import "DAOFarroupilha.h"
#import "DAOGeral.h"
#import "ClassificacaoCallMethods.h"
#import "Classificacao_Celula.h"
#import "VariaveisGlobais.h"
#import "globals.h"
#import "EGORefreshTableHeaderView.h"

@interface ClassificacaoViewController : UIViewController <UITableViewDataSource,
UITableViewDelegate,
FutebasMethodsDelegate, ClassificacaoCallMethodsDelegate, EGORefreshTableHeaderDelegate> {
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSTimer* checarCarregando;
}

@property int alturaTabela;

@property (strong, nonatomic) IBOutlet UISegmentedControl *scFases;
@property (strong, nonatomic) ClassificacaoCallMethods *classificacaoCallMethods;
@property (strong, nonatomic) NSMutableArray* arrayClassificacao;
@property (strong, nonatomic) IBOutlet UITableView *tabela;

- (IBAction)SCMudou:(id)sender;


@end
