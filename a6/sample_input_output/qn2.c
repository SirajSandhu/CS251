#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/time.h>
#include <pthread.h>

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

pthread_mutex_t condition_mutex[10000];
pthread_mutex_t count_mutex;
int c;
float balance[10000];
int statements = 0;
int num_txns;

typedef struct Reg{
    int id;
    int type;
    float amount;
    int ac1;
    int ac2;
} reg;

reg* txns;

void* func(){
    int id;
    int type;
    float amount;
    int ac1;
    int ac2;

    while(c < num_txns)
    {
        pthread_mutex_lock(&count_mutex);
        id = txns[c].id;
        type = txns[c].type;
        amount = txns[c].amount;
        ac1 = txns[c].ac1;
        ac2 = txns[c].ac2;
        c++;
        pthread_mutex_unlock(&count_mutex);

        pthread_mutex_lock(&condition_mutex[ac1 - 1001]);
        if (type == 1)
            balance[ac1-1001] += amount*0.99;

        if (type == 2)
            balance[ac1-1001] -= amount*1.01;

        if (type == 3)
            balance[ac1-1001] *= 1.071;

        if (type == 4) {
            pthread_mutex_lock(&condition_mutex[ac2 - 1001]);
            balance[ac1-1001] -= amount*1.01;
            balance[ac2-1001] += amount*0.99;
            pthread_mutex_unlock(&condition_mutex[ac2 - 1001]);
        }
        pthread_mutex_unlock(&condition_mutex[ac1 - 1001]);
    }
    pthread_exit(NULL);
}

int main(int argc, char **argv){
    c = 0;
    num_txns = atoi(argv[3]);
    int num_threads = atoi(argv[4]);
    txns = (reg*)malloc(num_txns * sizeof(reg));
    pthread_t threads[num_threads];
    struct timeval start, end;

    if(argc!= 5){
        printf("Usage: %s {Account_file},%s {Transaction_file},%s {#transactions},%s {#threads}", argv[1], argv[2], argv[3], argv[4]);
        exit(-1);
    }

    FILE* ACCOUNTS = fopen(argv[1],"r+");
    int cnt = 0;
    while(1){
        int f1;
        float f2;
        if(fscanf(ACCOUNTS, "%d %f", &f1, &f2) == 2){
            balance[cnt] = f2;
            cnt++;
        }
        else break;
    }
    fclose(ACCOUNTS);

    cnt = 0;
    FILE* TRANSACTIONS = fopen(argv[2],"r+");
    while(cnt < num_txns) {
        int f1;
        int f2;
        float f3;
        int f4;
        int f5;

        if(fscanf(TRANSACTIONS,"%d %d %f %d %d", &f1, &f2, &f3, &f4, &f5) == 5){
            txns[cnt].id = f1;
            txns[cnt].type = f2;
            txns[cnt].amount = f3;
            txns[cnt].ac1 = f4;
            txns[cnt].ac2 = f5;
            cnt++;
        }
        else break;
    }
    fclose(TRANSACTIONS);

    gettimeofday(&start, NULL);
    for (int i = 0; i < 10000; i ++)
        pthread_mutex_init(&condition_mutex[i], NULL);

    pthread_mutex_init(&count_mutex, NULL);

    int ctr;
    for(ctr = 0; ctr < num_threads; ++ctr) {
        if (pthread_create(&threads[ctr], NULL, func, NULL) != 0) {
            perror("pthread_create");
            exit(-1);
        }
    }

    for(ctr = 0; ctr < num_threads; ++ctr)
         pthread_join(threads[ctr], NULL);

    for(ctr = 0; ctr < 10000; ++ctr)
        printf("%d %.2f\n", ctr+1001, balance[ctr]);

    gettimeofday(&end, NULL);
    printf("Time taken = %ld microsecs\n", TDIFF(start, end));
    return 0;
}
