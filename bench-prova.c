#include <stdio.h>
#include <time.h> 
#include <math.h>
#include <stdlib.h>
#include <string.h>

void copyA(int *dst, int *src, int size){
  int i, j;
  for(i=0; i<size; i++){
	for(j=i*4; j<i*4+4; j++){
	  dst[j]=src[j];
	}
  }
}

void copy4(int *dst, int *src){
  memcpy(dst,src,4);
}

void copyB(int *dst, int *src, int size){
  int i;
  for(i=0; i<size; i++){
	copy4(dst+4*i,src+4*i);
  }
}

void copyC(int *dst, int *src, int size){
  int i;
  for(i=0; i<size; i++){
	memcpy(dst+4*i,src+4*i,4);
  }
}

void copyD(int *dst, int *src, int size){
  int i, j;
  memcpy(dst,src,4*size);
}


int main (){
  clock_t t;
  int i;
  int *src, *dst, size;
  // size - numero de linhas da matriz
  // src - matriz de origem
  // dst - matriz de destino
  size = 400;
  
  /* funcao copyA */
  printf ("Calculating...\n");
  t = clock();
  for(i=0; i<500000; i++){
	copyA(dst,src,size);
  }
  t = clock() - t;
  printf ("copyA: %d clicks (%f seconds).\n",
		  (int)t,((float)t)/CLOCKS_PER_SEC);
	  
  
  /* funcao copyB */
  printf ("Calculating...\n");
  t = clock();
  for(i=0; i<500000; i++){
	copyB(dst,src,size);
  }
  t = clock() - t;
  printf ("copyB: %d clicks (%f seconds).\n",
		  (int)t,((float)t)/CLOCKS_PER_SEC);

  /* funcao copyC */
  printf ("Calculating...\n");
  t = clock();
  for(i=0; i<500000; i++){
	copyC(dst,src,size);
  }
  t = clock() - t;
  printf ("copyC: %d clicks (%f seconds).\n",
		  (int)t,((float)t)/CLOCKS_PER_SEC);

  /* funcao copyD */
  printf ("Calculating...\n");
  t = clock();
  for(i=0; i<500000; i++){
	copyD(dst,src,size);
  }
  t = clock() - t;
  printf ("copyD: %d clicks (%f seconds).\n",
		  (int)t,((float)t)/CLOCKS_PER_SEC);

  return 0;
}