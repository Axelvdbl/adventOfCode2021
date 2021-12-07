CC			=	gcc

CFLAGS		=	-Wall -Wextra -O2

LDFLAGS		=	-lm

SRC			=	src/dayOne.c

OBJ			=	$(SRC:.c=.o)

NAME		=	dayOne

$(NAME):	$(OBJ)
			$(CC) $(OBJ) $(LDFLAGS) -o $(NAME)

all:		$(NAME)

clean:
			rm -f $(OBJ)

fclean:		clean
			rm -f $(NAME)

re:			fclean all