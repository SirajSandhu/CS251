#include <stdio.h>
#include <stdlib.h>

int main(void) {
  int account[10000];
  double balance[10000];
  FILE *fp;

  int i = 0;
  fp = fopen("acc.txt", "r");

  if (fp != NULL) {
    while (!feof(fp)) {
      if (fscanf(fp, "%d %lf", &account[i], &balance[i]) != 2) continue;
      i++;
    }
  }

  fclose(fp);
  return 0;
}
