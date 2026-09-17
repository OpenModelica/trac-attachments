#include <stdio.h>
#include <stdlib.h>
#include "libxl.h"
#include "ModelicaUtilities.h"

void* initExcelReader(const char* fileName) {
  BookHandle *book = malloc(sizeof(BookHandle));
  *book = xlCreateBook();

  if(!xlBookLoad(*book, fileName)) {
    ModelicaFormatError("Couldn't open excel sheet %s\n", fileName);
  }
  return (void*)book;
}

void closeExcelReader(void* reader) {
  BookHandle *book = (BookHandle*)reader;
  if (reader == NULL) return;
  xlBookRelease(*book);
  free(book);
}

double readExcelSheet(void *reader, double time) {
  BookHandle *book = (BookHandle*)reader;
  double k;
  double SpeedProfile[11][2];
  unsigned t, p;

	SheetHandle sheet = xlBookGetSheet(*book, 0);

  if (sheet == NULL) {
    ModelicaFormatError("Couldn't get sheet: %s\n", xlBookErrorMessage(*book));
  }

	for (t = 0; t <= 10; t++)
	{
		SpeedProfile[t][0] = xlSheetReadNum(sheet, t + 1, 1, NULL);
		SpeedProfile[t][1] = xlSheetReadNum(sheet, t + 1, 2, NULL);
	}
	
	for (p = 0; p <= 9; p++)
	{
		if ((time >= SpeedProfile[p][0]) && (time < SpeedProfile[p + 1][0]))
		{
			k = SpeedProfile[p][1];
		}
	}
	if (time < 0)
		k = 0;
	if (time > SpeedProfile[10][0])
		k = 0;

  if (strcmp(xlBookErrorMessage(*book), "ok") != 0) {
    ModelicaFormatError("Error: %s\n", xlBookErrorMessage(*book));
  }

  return k;
}
