# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yoel <yoel@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/24 18:26:55 by gamoreno          #+#    #+#              #
#    Updated: 2023/10/01 23:17:05 by yoel             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

### Compilation ###

CC	= nvcc
CFLAGS	= -g -G#-Wall -Wextra -Werror -g3 -I.

### Executable ###

NAME	=	libft.a

### Inculdes ###

OBJ_PATH = objs/
HEADER = ../../includes/
SRC_PATH = sources/
MLX = ../../libs/minilibx-linux
LIBFT = ../../libs/libft
INCLUDES = -I $(HEADER) -I $(MLX) -I $(LIBFT)/includes

### Sources ###

FTSTR_DIR	=	ft_str/
FTSTR		=	ft_strcmp.cu ft_strchr.cu ft_substr.cu ft_strlen.cu\
				ft_strdup.cu ft_strjoin.cu ft_split.cu ft_split_ws.cu

FTMATH_DIR	=	ft_math/
FTMATH		=	ft_atof.cu ft_isdigit.cu ft_itoa.cu ft_ftoa.cu ft_abs.cu\
				ft_atoli.cu ft_atoi.cu 

FTPUT_DIR	=	ft_put/
FTPUT		=	ft_putstr_fd.cu

FTMEM_DIR	=	ft_mem/
FTMEM		=	ft_bzero.cu ft_calloc.cu ft_memcpy.cu

SOURCES		+=	$(addprefix	$(FTSTR_DIR),$(FTSTR))
SOURCES		+=	$(addprefix	$(FTMATH_DIR),$(FTMATH))
SOURCES		+=	$(addprefix	$(FTPUT_DIR),$(FTPUT))
SOURCES		+=	$(addprefix	$(FTMEM_DIR),$(FTMEM))
### Objects ###

SRCS = $(addprefix $(SRC_PATH),$(SOURCES))
OBJS = $(addprefix $(OBJ_PATH),$(SOURCES:.cu=.o))
DEPS = $(addprefix $(OBJ_PATH),$(SOURCES:.cu=.d))

### COLORS ###
NOC         = \033[0m
GREEN       = \033[1;32m
CYAN        = \033[1;36m

### RULES ###

all:		tmp $(NAME)

$(NAME):	$(OBJS)
		ar rcs $(NAME) $(OBJS)
		@echo "$(GREEN)libft made succesfully$(NOC)"

tmp:
		@mkdir -p $(OBJ_PATH)
		@mkdir -p $(OBJ_PATH)$(FTSTR_DIR)
		@mkdir -p $(OBJ_PATH)$(FTMATH_DIR)
		@mkdir -p $(OBJ_PATH)$(FTPUT_DIR)
		@mkdir -p $(OBJ_PATH)$(FTMEM_DIR)

$(OBJ_PATH)%.o: $(SRC_PATH)%.cu
		@$(CC) $(FLAGS) $(INCLUDES) -MMD -c -o $@ $<
		@echo "$(CYAN)Creation of object file -> $(CYAN)$(notdir $@)... $(GREEN)[Done]$(NOC)"

clean:
		rm -rf $(OBJ_PATH)


fclean:		clean
		rm -f $(NAME)

re:		fclean all

-include $(DEPS)

.PHONY:		all clean fclean re bonus
