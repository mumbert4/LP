#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>
#include <set>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0

uint numVars;
uint numClauses;
vector<vector<int> > clauses;
vector<int> model; //model actual, inicialment a UNDEFINED, i passaran a ser vertaderes o falses, per saber si la variable es UNDEF, TRUE, FALSE
vector<int> modelStack; //pila, per el backtracking
uint indexOfNextLitToPropagate; //nomes s'usa en el backtrack, apunta a la pila de literals, apunta al seguent literal que esta pendent de ser propagat
uint decisionLevel; //nivell de decisio de la pila, si == 0 -> insatisfactible, sinos fein backtracking, per saber a quin nivell de la pila tenim una decisio nostra, quantes decisions nostres tenim dins la pila

//heuristica dinamica-> a cada conflicte de una clausula, incrementam un contador de conflictes per cada valor de la clausula       
//27 -34 -57
//++con[27] ++con[34] ++con[57] activity based heuristic   mejora: actividad reciente: anar dividint /2 els contadors cada 100 conflictes la divideixes                                                                                                                                  


vector<set<int>> posClausules;
vector<set<int>> negClausules;
vector<int> num_clausules; 
int conflicts = 0 ;

void readClauses( ){
  // Skip comments
  char c = cin.get();
  while (c == 'c') {
    while (c != '\n') c = cin.get();
    c = cin.get();
  }  
  // Read "cnf numVars numClauses"
  string aux;
  cin >> aux >> numVars >> numClauses;
  clauses.resize(numClauses);  


  posClausules.resize(numClauses + 1); // vector de les clausules on el numero es positiu
  negClausules.resize(numClauses + 1); // vector de les clausules on el numero es negatiu
  num_clausules.resize(numVars + 1, 0 ); // vector amb el nombre de clausules que te el numero
  //validDecisionLit.resize(numVars+1, true); //vector per si un decisionLit es valid dins la nostra 
  // Read clauses
  for (uint i = 0; i < numClauses; ++i) {
    int lit;
    while (cin >> lit and lit != 0){
      clauses[i].push_back(lit);
      if(lit > 0) {
        posClausules[lit].insert(i);
        ++num_clausules[lit];
      }

      else{
        negClausules[-lit].insert(i);
        ++num_clausules[-lit];
      } 
    } 
  }    
}


void act_num_clausules(){
    for(uint i=0; i< num_clausules.size(); ++i){
        num_clausules[i] = num_clausules[i]/2;
    }
    conflicts = 0;
}


int currentValueInModel(int lit){
  if (lit >= 0) return model[lit]; //si literal es positiu, retornam TRUE
  else {
    if (model[-lit] == UNDEF) return UNDEF;
    else return 1 - model[-lit]; 
  }
}


void setLiteralToTrue(int lit){
  modelStack.push_back(lit);
  if (lit > 0) model[lit] = TRUE;
  else model[-lit] = FALSE;		
}

//saber quines clausules tenen el darrer numero de la pila girat, si tenim un 3 al principi, cercar les clausules on la variable surt girada (-3), llista de possibles clausules.
// 1 : 34, 56, 123... llista de clausules on surt el literal 1 
// -1 : 55, 2 , 40.... llista de clausules on surt el literal -1

/*
bool propagateGivesConflict ( ) {
  while ( indexOfNextLitToPropagate < modelStack.size() ) { // a la primera iteracio no entram aqui
    ++indexOfNextLitToPropagate;
    for (uint i = 0; i < numClauses; ++i) {//recorrem totles les clausules
      bool someLitTrue = false;
      int numUndefs = 0;
      int lastLitUndef = 0;
      for (uint k = 0; not someLitTrue and k < clauses[i].size(); ++k){//miram els numeros de les clausules
        int val = currentValueInModel(clauses[i][k]);
        if (val == TRUE) someLitTrue = true; //trobam un valor diferent del que ja esta dins la pila i li ficam 
        else if (val == UNDEF){ ++numUndefs; lastLitUndef = clauses[i][k]; }
      }
      if (not someLitTrue and numUndefs == 0) return true; // conflict! all lits false // si decision level == 0-> insatifiable, else -> backtrack()
      else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);	
    }    
  }
  return false;
}*/


bool propagateGivesConflict ( ) {
  while ( indexOfNextLitToPropagate < modelStack.size() ) { // a la primera iteracio no entram aqui

    int darrer_num = modelStack[indexOfNextLitToPropagate]; //numero mes alt de la pila
    //cout<<' '<<darrer_num;
    ++indexOfNextLitToPropagate;
    set<int>* p_set;
    if(darrer_num >= 0) p_set = &negClausules[darrer_num];
    else p_set = &posClausules[-darrer_num];
    
    for(set<int>::iterator it = p_set->begin(); it != p_set->end(); ++it ){
        int c = *it; //clausula actual
        bool someLitTrue = false;
        int numUndefs =0;
        int lastLitUndef = 0;
        for(uint k =0; k< clauses[c].size() and not someLitTrue; ++k){
            int val = currentValueInModel(clauses[c][k]);
            if(val==TRUE) someLitTrue = true;
            else if (val == UNDEF) {++numUndefs; lastLitUndef = clauses[c][k];}
        }
        if (not someLitTrue and numUndefs == 0) {
            for(uint k =0; k< clauses[c].size(); ++k) ++num_clausules[ abs( clauses[c][k] ) ];
            ++conflicts;
            if(conflicts == 100) act_num_clausules();
            return true;   
        }
        else if(not someLitTrue and numUndefs == 1 )setLiteralToTrue(lastLitUndef);
    }
  }    
  
  return false;
}


void backtrack(){
  uint i = modelStack.size() -1;
  int lit = 0;
  while (modelStack[i] != 0){ // 0 is the DL mark
    lit = modelStack[i];
    model[abs(lit)] = UNDEF;
    modelStack.pop_back();
    --i;
  }
  // at this point, lit is the last decision
  modelStack.pop_back(); // remove the DL mark
  --decisionLevel;
  indexOfNextLitToPropagate = modelStack.size();
  setLiteralToTrue(-lit);  // reverse last decision-> ficam el numero contrari
}


// Heuristic for finding the next decision literal: // HEM DE MILLORAR -> decidir sobre les variables que tenguin moltes propagacions, sustuir la funcio, retornar les variables amb mes impacte possible
int getNextDecisionLiteral(){
  int max= -1;
  int lit = 0; 
  for (uint i = 1; i <=numVars; ++i ){
      if (model[i] == UNDEF and (num_clausules[i] > max )){
        lit = i;
        max = num_clausules[i];
      }
  }  
  return lit;
}


// int getNextDecisionLiteral(){
//   for (uint i = 1; i <= numVars; ++i) // stupid heuristic:
//     if (model[i] == UNDEF) return i;  // returns first UNDEF var, positively
//   return 0; // reurns 0 when all literals are defined
// }

void checkmodel(){
  for (uint i = 0; i < numClauses; ++i){
    bool someTrue = false;
    for (uint j = 0; not someTrue and j < clauses[i].size(); ++j)
      someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
    if (not someTrue) {
      cout << "Error in model, clause is not satisfied:";
      for (uint j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << " ";
      cout << endl;
      exit(1);
    }
  }  
}

int main(){ 
  readClauses(); // reads numVars, numClauses and clauses
  model.resize(numVars+1,UNDEF);
  indexOfNextLitToPropagate = 0;  
  decisionLevel = 0;
  
  // Take care of initial unit clauses, if any
  for (uint i = 0; i < numClauses; ++i)
    if (clauses[i].size() == 1) {
      int lit = clauses[i][0];
      int val = currentValueInModel(lit);
      if (val == FALSE) {cout << "UNSATISFIABLE" << endl; return 10;}
      else if (val == UNDEF) setLiteralToTrue(lit);
    }
  
  // DPLL algorithm
  while (true) {
    while ( propagateGivesConflict() ) { //primera iteracio no entram
      if ( decisionLevel == 0) { cout << "UNSATISFIABLE" << endl; return 10; }
      backtrack(); //else
    }
    int decisionLit = getNextDecisionLiteral(); //retorna el seguent literal sobre el que decidirem
    if (decisionLit == 0) { checkmodel(); cout << "SATISFIABLE" << endl; return 20; } //retorna 0 si no podem assignar mes variables i a mes no hi ha cap conflicte
    // start new decision level: ha retornat un literal diferent
    modelStack.push_back(0);  // push mark indicating new DL - a la nostra pila tendrem un 0 quan sigui una decisio, sinos es una propagacio, 
    //backtrack fa pops fins que sigui una decisio, quan la trobam, la ficam al reves (la negam), aqui ficam a la pila una decisio nostra
    ++indexOfNextLitToPropagate;//
    ++decisionLevel;
    setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark -- a la pila de veritat li ficam el nostre valor
  }
}  
