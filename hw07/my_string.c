/**
 * @file my_string.c
 * @author KALANI DISSANAYAKE
 * @collaborators NAMES OF PEOPLE THAT YOU COLLABORATED WITH HERE
 * @brief Your implementation of these famous 3 string.h library functions!
 *
 * NOTE: NO ARRAY NOTATION IS ALLOWED IN THIS FILE
 *
 * @date 2023-03-17
 */

#include <stddef.h>
#include "my_string.h"
/**
 * @brief Calculate the length of a string
 *
 * @param s a constant C string
 * @return size_t the number of characters in the passed in string
 */
size_t my_strlen(const char *s)
{
  int length = 0;
  while (*s != '\0') {
    length++;
    s++;
  }

  return length;
}

/**
 * @brief Compare two strings
 *
 * @param s1 First string to be compared
 * @param s2 Second string to be compared
 * @param n First (at most) n bytes to be compared
 * @return int "less than, equal to, or greater than zero if s1 (or the first n
 * bytes thereof) is found, respectively, to be less than, to match, or be
 * greater than s2"
 */
int my_strncmp(const char *s1, const char *s2, size_t n)
{
  while (n > 0) {
    if (*s1 > *s2) {
      return 1;
    } else if (*s1 < *s2) {
      return -1;
    } else if (*s1 == '\0' && *s2 == '\0') {
      return 0;
    }
    s1++;
    s2++;
    n--;
  }
  return 0;
}

/**
 * @brief Copy a string
 *
 * @param dest The destination buffer
 * @param src The source to copy from
 * @param n maximum number of bytes to copy
 * @return char* a pointer same as dest
 */
char *my_strncpy(char *dest, const char *src, size_t n)
{
    char *i = dest;
    int d = 0;
    while (n > 0) {
      if (*src == '\0') {
        d = 1;
      }
      if (d == 1) {
        *i = '\0';
      } else {
        *i = *src;
      }
      src++;
      i++;
      n--;
    }

    return dest;
}

/**
 * @brief Concatenates two strings and stores the result
 * in the destination string
 *
 * @param dest The destination string
 * @param src The source string
 * @param n The maximum number of bytes from src to concatenate
 * @return char* a pointer same as dest
 */
char *my_strncat(char *dest, const char *src, size_t n)
{
  char *i = dest;
  while (*i != '\0') {
    i++;
  }
  while (n > 0) {
    if (*src == '\0') {
      break;
    }
    *i = *src;
    src++;
    n--;
    i++;
  }

  *i = '\0';
  return dest;
}

/**
 * @brief Copies the character c into the first n
 * bytes of memory starting at *str
 *
 * @param str The pointer to the block of memory to fill
 * @param c The character to fill in memory
 * @param n The number of bytes of memory to fill
 * @return char* a pointer same as str
 */
void *my_memset(void *str, int c, size_t n)
{
  char *pointer = str;
  while (n > 0) {
    *pointer = c;
    n--;
    pointer++;
  }
  return str;
}

/**
 * @brief Finds the first instance of c in str
 * and removes it from str in place
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 */
void remove_first_instance(char *str, char c){
  char *pointer = str;
  while (*pointer != '\0') {
      if (*pointer == c) {
          while (*pointer != '\0') {
              *pointer = *(pointer + 1);
              pointer++;
          }
          break;
      }
      pointer++;
  }
}

/**
 * @brief Finds the first instance of c in str
 * and replaces it with the contents of replaceStr
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 * @param replaceStr The pointer to the string we are replacing c with
 */
void replace_character_with_string(char *str, char c, char *replaceStr) {
int l = my_strlen(replaceStr);
if (l == 0) {
  remove_first_instance(str, c);
  return;
}
  while (*str != '\0') { // loop until end of string is reached
    if (*str == c) { // check if current character is c
      char *temp = str;
      int length = my_strlen(temp + 1);
      int i = length;
      while (i >= 0) {
        *(str + i + l) = *((temp + 1) + i);
        i--;
      }
      for (int j=0; j < l; j++) {
        *(str+j) = *(replaceStr + j);
      }
      break; // break after replacement is done
    }
    str++; // move to next character
  }
  return;
}

/**
 * @brief Remove the first character of str (ie. str[0]) IN ONE LINE OF CODE.
 * No loops allowed. Assume non-empty string
 * @param str A pointer to a pointer of the string
 */
void remove_first_character(char **str) {
    ++(*str);
}
