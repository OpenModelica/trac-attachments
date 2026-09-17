#include <stdio.h>

void calculate1(double step, int n, double *arr)
{
  int j = 0;
  for (j ; j < n ; j++) {
    //fprintf(stdout, "before calculate1 arr[%d] = %f, step = %f\n", j, arr[j], step);fflush(NULL);
  }
  arr[0] += 1;
  arr[1] += 2;
  for (j = 0 ; j < n ; j++) {
    //fprintf(stdout, "after calculate1 arr[%d] = %f, step = %f\n", j, arr[j], step);fflush(NULL);
  }
}

void calculate2(double step, int n, double *arr, int *sldone)
{
  int j = 0;
  for (j ; j < n ; j++) {
    //fprintf(stdout, "before calculate2 arr[%d] = %f, step = %f\n", j, arr[j], step);fflush(NULL);
  }
  arr[0] += 1;
  arr[1] += 2;
  for (j = 0 ; j < n ; j++) {
    //fprintf(stdout, "after calculate2 arr[%d] = %f, step = %f\n", j, arr[j], step);fflush(NULL);
  }
}