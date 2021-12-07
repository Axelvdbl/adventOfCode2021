#include <stdio.h>
#include <stdlib.h>

int total_bigger = 0;
int previous = 0;
int current = 0;
int line_number = 0;

int records[3];

void isBigger(int line_value)
{
  if (!previous)
  {
    previous = line_value;
    return;
  }
  else
  {
    current = line_value;
  }

  if (current > previous)
    total_bigger += 1;
  previous = current;
}

void setArray(int line_value)
{
  records[line_number % 3] = line_value;

  if (records[2])
    isBigger(records[0] + records[1] + records[2]);
}

void readFile(char *filename)
{
  FILE *fp;
  char *line = NULL;
  size_t len = 0;
  ssize_t read;

  fp = fopen(filename, "r");
  if (fp == NULL)
    exit(EXIT_FAILURE);

  while ((read = getline(&line, &len, fp)) != -1)
  {
    setArray(atoi(line));
    line_number += 1;
  }

  fclose(fp);
  if (line)
    free(line);
  printf("Answer is : %i\n", total_bigger);
  exit(EXIT_SUCCESS);
}

int main(int ac, char **av)
{
  if (ac != 2)
    exit(EXIT_FAILURE);
  readFile(av[1]);
}