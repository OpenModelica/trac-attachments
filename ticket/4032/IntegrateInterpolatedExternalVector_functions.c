#include "IntegrateInterpolatedExternalVector_functions.h"
#ifdef __cplusplus
extern "C" {
#endif

#include "IntegrateInterpolatedExternalVector_literals.h"
#include "IntegrateInterpolatedExternalVector_includes.h"



void omc_VectorTable_destructor(threadData_t *threadData, modelica_complex _table)
{
  void * _table_ext;
  void * _table_ext;
  _table_ext = (void *)_table;
  _table_ext = (void *)_table;
  _table_ext = destroyVectorTable(_table_ext);
  return;
}
void boxptr_VectorTable_destructor(threadData_t *threadData, modelica_metatype _table)
{
  omc_VectorTable_destructor(threadData, _table);
  return;
}
modelica_real omc_InterpolateExternalVector(threadData_t *threadData, modelica_real _x, modelica_complex _table)
{
  void * _table_ext;
  double _x_ext;
  double _y_ext;
  modelica_real _y;
  _table_ext = (void *)_table;
  _x_ext = (double)_x;
  _y_ext = interpolateVectorTable(_table_ext, _x_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_InterpolateExternalVector(threadData_t *threadData, modelica_metatype _x, modelica_metatype _table)
{
  modelica_real tmp1;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_x);
  _y = omc_InterpolateExternalVector(threadData, tmp1, _table);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_complex omc_VectorTable_constructor(threadData_t *threadData, real_array _ybar)
{
  void *_ybar_c89;
  void * _table_ext;
  modelica_complex _table;
  _ybar_c89 = (void*) data_of_real_c89_array(&(_ybar));
  _table_ext = createVectorTable((const double*) _ybar_c89, size_of_dimension_base_array(_ybar, ((modelica_integer) 1)));
  _table = (modelica_complex)_table_ext;
  return _table;
}
modelica_metatype boxptr_VectorTable_constructor(threadData_t *threadData, modelica_metatype _ybar)
{
  modelica_complex _table;
  _table = omc_VectorTable_constructor(threadData, *((base_array_t*)_ybar));
  /* skip box _table; ExternalObject VectorTable */
  return _table;
}

#ifdef __cplusplus
}
#endif
