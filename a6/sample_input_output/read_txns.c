#include <stdio.h>
#include <stdlib.h>

typedef struct Reg{
	int tseq;
	int type;
	double amount;
	int ac1;
	int ac2;
} reg;

int main(void) {
  int num_txns = 100;
  reg txn[num_txns];

  FILE *fp;

  int i = 0;
  fp = fopen("txn.txt", "r");

  if (fp != NULL) {
    while (!feof(fp) && i < num_txns) {
      if (fscanf(fp, "%d %d %lf %d %d", &txn[i].tseq, &txn[i].type, &txn[i].amount, &txn[i].ac1, &txn[i].ac2) != 5) continue;
      i++;
    }
  }

  fclose(fp);
  for (i = 0; i < 5; i++) printf("%d, %lf : %d -> %d\n", txn[i].type, txn[i].amount, txn[i].ac1, txn[i].ac2);
  return 0;
}
