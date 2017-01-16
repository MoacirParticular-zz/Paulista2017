//
//  ListaDeJogosViewController.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListaDeJogos_Celula.h"
#import "DAOJogo.h"
#import "JogoCallMethods.h"
#import "VariaveisGlobais.h"
#import "globals.h"
#import "EGORefreshTableHeaderView.h"
#import "CompartilharJogo_ViewController.h"

@interface ListaDeJogosViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, FutebasMethodsDelegate, JogoMethodsDelegate, EGORefreshTableHeaderDelegate> {
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSTimer* checarCarregando;
}


@property int alturaTabela;
@property (strong, nonatomic) NSArray* arrayPrimeiroTurno;
@property (strong, nonatomic) NSArray* arraySegundoTurno;
@property (strong, nonatomic) NSArray* arrayFinais;
@property (strong, nonatomic) NSArray* arrayRodadas;
@property (strong, nonatomic) JogoCallMethods* jogoCalMetodo;
@property (strong, nonatomic) IBOutlet UITableView *tabela;
@property (strong, nonatomic) IBOutlet UISegmentedControl *meuSC;
@property (nonatomic) int nrRodadaPrimeiroTurno;
@property (nonatomic) int nrRodadaSegundoTurno;
@property (nonatomic) int nrRodadaFinal;
@property (strong, nonatomic) IBOutlet UILabel *lb_Rodada;

@property (nonatomic) BOOL isFirstTime;


- (IBAction)SCMudou:(id)sender;

- (IBAction)RodadaAnterior:(id)sender;
- (IBAction)ProximaRodada:(id)sender;

@end
