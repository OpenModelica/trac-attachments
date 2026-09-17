
#include <stdio.h>
#include <malloc.h>

typedef struct TestObject
{
  double value;
} TestObject;


void* initTest(double value)
{
  TestObject* obj = (TestObject*) malloc(sizeof(TestObject));
  obj->value = value;
  return obj;
}


void clearTest(void* object)
{
  TestObject* obj = (TestObject*) object;
  free(obj);
}

void evaluateTest(void* object, double time, double* value)
{
  TestObject* obj = (TestObject*) object;
  *value = obj->value;
}
