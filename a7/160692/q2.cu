#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

#define CUDA_ERROR_EXIT(str)  do{\
                                cudaError err = cudaGetLastError();\
                                if( err != cudaSuccess){\
                                  printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                  exit(-1);\
                                }\
                              }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

__global__ void compute(int *mem, int n, int skip) {
    int index;
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    if(i >= n) return;
    index = i/skip;
    if(i % skip == 0) {
        if(index % 2) { //odd index
            //store at the end;
            if(i + skip - 1 >= n) {
                if(i != n - 1) {
                    *(mem + (n - 1)) =  *(mem + (n - 1)) ^ *(mem + (i));
                    *(mem + i) = 0; //because a ^ 0 = a;
                }
            }
            else {
                *(mem + (i + skip - 1)) =  *(mem + (i + skip - 1)) ^ *(mem + (i));
                *(mem + i) = 0;     //because a ^ 0 = a;
            }
        }
        else {
            if(i + skip - 1 >= n) {
                if(i != n - 1) {
                    *(mem + i) =  *(mem + (n - 1)) ^ *(mem + (i));
                    *(mem + (n - 1)) = 0; //because a ^ 0 = a;
                }
            }
            else {
                *(mem + i) =  *(mem + (i)) ^ *(mem + (i + skip - 1));
                *(mem + (i + skip - 1)) = 0; //because a ^ 0 = a;
            }
        }
    }
}

int main(int argc, char **argv)
{
    struct timeval start, end, t_start, t_end;
    int ctr;
    int *a;
    int *gpu_mem;
    int blocks;

    int n = atoi(argv[1]);
    int seed = atoi(argv[2]);

    /* Allocate host (CPU) memory and initialize*/
    a = (int*)malloc(n * sizeof(int));

    srand(seed);
    for (ctr = 0; ctr < n; ++ctr)
        a[ctr] = random();

    gettimeofday(&t_start, NULL);

    /* Allocate GPU memory and copy from CPU --> GPU*/
    cudaMalloc(&gpu_mem, n * sizeof(int));
    CUDA_ERROR_EXIT("cudaMalloc");

    cudaMemcpy(gpu_mem, a, n * sizeof(int) , cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("cudaMemcpy");

    gettimeofday(&start, NULL);

    int skip;
    blocks = n /1024;
    if (n % 1024)
        ++blocks;
    for (skip = 2; skip < 2*n; skip *= 2)
        compute<<<blocks, 1024>>>(gpu_mem, n, skip);

    CUDA_ERROR_EXIT("kernel invocation");
    gettimeofday(&end, NULL);

    /* Copy back result*/
    cudaMemcpy(a, gpu_mem, n * sizeof(int) , cudaMemcpyDeviceToHost);
    CUDA_ERROR_EXIT("memcpy");

    gettimeofday(&t_end, NULL);

    printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
    cudaFree(gpu_mem);

    /*int *number = (int *) (a);*/
    printf("%d \n", *(a));

    free(a);
}
