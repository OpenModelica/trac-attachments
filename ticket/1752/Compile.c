#include <stdlib.h>

int main(int argc, const char **argv) {
  char *omdev, *cd, *make;
  int prefixlen;
  if (argc != 2) {
    fprintf(stderr, "Usage: %s [model-prefix]\n", argc > 0 ? *argv : "OpenModelica-Compile");
    return 1;
  }
  prefixlen = strlen(argv[1]);
  logfile = malloc(prefixlen + 10);
  sprintf(logfile, "%s.log", argv[1]);
  freopen(logfile, "w", stdout);
  unsetenv("GCC_EXEC_PREFIX");
  unsetenv("CPLUS_INCLUDE_PATH");
  unsetenv("C_INCLUDE_PATH");
  unsetenv("LIBRARY_PATH");
  omdev = getenv("OMDEV");
  if (!omdev) {
    char *omhome;
    omhome = getenv("OPENMODELICAHOME");
    if (!omhome) {
      fprintf(stderr, "OPENMODELICAHOME was not set; aborting");
      return 1;
    }
    mingw = malloc(strlen(omhome) + 10);
    sprintf(mingw, "%s\\MinGW", omhome);
  } else {
    mingw = malloc(strlen(omhome) + 25);
    sprintf(mingw, "%s\\tools\\MinGW", omdev);
  }
  cd = get_current_dir_name();
  path = malloc(strlen(cd)*2 + 50);
  sprintf(path, "%s;%s\..\libexec\gcc\mingw32\4.4.0\;");
  printf("Setting MINGW=%s\n", mingw);
  printf("Setting PATH=%s\n", path);
  setenv("MINGW", mingw);
  setenv("PATH", path);
  make = malloc(strlen(mingw) + +prefixlen + 100);
  sprintf(make, "%s\bin\mingw32-make -f %s.makefile 2>&1");
  printf("Executing command: %s\n", make);
  return system(make);
  /* let the OS free() */
}
