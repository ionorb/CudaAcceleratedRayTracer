# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yoel <yoel@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/19 18:59:58 by gamoreno          #+#    #+#              #
#    Updated: 2023/10/08 20:16:29 by yoel             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

### Compilation ###

CC      = gcc
NVCC    = nvcc

NVCCFLAGS = -g -G -rdc=true
# FLAGS  = -Wall -Wextra -pthread -g3
# FLAGS  += -Ofast -flto
### Executable ###
NAME   = minirt

### Includes ###

OBJ_PATH  = objs/
HEADER = includes/
SRC_PATH  = sources/
MLX = libs/minilibx-linux
LIBFT = libs/libft
CUDA = -I/usr/local/cuda/include -L/usr/local/cuda/lib
INCLUDES = -I $(HEADER) -I $(MLX) -I $(LIBFT)/includes $(CUDA)

### Source Files ###
CORE_DIR	=	core/
CORE		=	main.cu \
				init.cu \
				init2.cu \
				keypress.cu \
				key_cam.cu \
				key_move_obj.cu \
				key_move_obj2.cu \
				key_rot_obj.cu \
				key_options.cu \
				key_options2.cu \
				mousepress.cu \
				info_display.cu \
				color_names.cu \
				set_bump_map.cu \
				bump_map_utils.cu \

PARSE_DIR	=	parse/
PARSE		=	parsing.cu \
				fill_objects.cu \
				fill_options.cu \
				parsing_utils.cu \
				cell_filling.cu \
				cell_filling_utils.cu \
				save_scene.cu \
				save_utils.cu \
				write_objects.cu \
				eval_objects.cu \
				fill_capitals.cu \
				# fill_options2.cu \

UTIL_DIR	=	utils/
UTILS		=	tools.cu \
				memory.cu \
				memory_utils.cu \
				mem_redefs.cu \
				free.cu \
				list_utils.cu \

MAT_DIR		=	math/
MAT			=	math1.cu \
				math2.cu \
				math3.cu \
				math4.cu \
				math5.cu \
				math6.cu \
				math7.cu \
				math8.cu \

CAM_DIR		=	cam/
CAM			=	cam.cu \
				paint.cu \
				paint_utils.cu \
				chosen_obj.cu \
				
COLOR_DIR	=	color/
COLOR		=	color.cu \
				color_utils.cu \
				color_utils2.cu \
				radiance.cu \
				intersections.cu \

PLANE_DIR	=	plane/
PLANE		=	plane.cu \
				plane_color.cu \
				triangle.cu \
				plane_bump.cu \
				plane_texture.cu \
				
SPHERE_DIR	=	sphere/
SPHERE		=	sphere.cu \
				sphere_color.cu \
				sphere_bump.cu \

CYLIN_DIR	=	cylinder/
CYLIN		=	cylinder.cu \
				cylinder_utils.cu \
				cylinder_utils2.cu \
				cylinder_color.cu \

CONE_DIR	=	cone/
CONE		=	cone.cu \
				cone_utils.cu \
				cone_utils2.cu \
				cone_utils3.cu \
				cone_color.cu \
				cone_texture.cu \

OBJ_DIRS	+=	$(addprefix	$(OBJ_PATH),$(CORE_DIR))
OBJ_DIRS	+=	$(addprefix	$(OBJ_PATH),$(PARSE_DIR))
OBJ_DIRS	+=	$(addprefix	$(OBJ_PATH),$(UTIL_DIR))
OBJ_DIRS	+=	$(addprefix	$(OBJ_PATH),$(MAT_DIR))
OBJ_DIRS	+=	$(addprefix	$(OBJ_PATH),$(CAM_DIR))
OBJ_DIRS	+=	$(addprefix	$(OBJ_PATH),$(COLOR_DIR))
OBJ_DIRS	+=	$(addprefix	$(OBJ_PATH),$(PLANE_DIR))
OBJ_DIRS	+=	$(addprefix	$(OBJ_PATH),$(SPHERE_DIR))
OBJ_DIRS	+=	$(addprefix	$(OBJ_PATH),$(CYLIN_DIR))
OBJ_DIRS	+=	$(addprefix	$(OBJ_PATH),$(CONE_DIR))

SOURCES		+=	$(addprefix	$(CORE_DIR),$(CORE))
SOURCES		+=	$(addprefix	$(PARSE_DIR),$(PARSE))
SOURCES		+=	$(addprefix	$(UTIL_DIR),$(UTILS))
SOURCES		+=	$(addprefix	$(MAT_DIR),$(MAT))
SOURCES		+=	$(addprefix	$(CAM_DIR),$(CAM))
SOURCES		+=	$(addprefix	$(COLOR_DIR),$(COLOR))
SOURCES		+=	$(addprefix	$(PLANE_DIR),$(PLANE))
SOURCES		+=	$(addprefix	$(SPHERE_DIR),$(SPHERE))
SOURCES		+=	$(addprefix	$(CYLIN_DIR),$(CYLIN))
SOURCES		+=	$(addprefix	$(CONE_DIR),$(CONE))

### Objects ###

SRCS = $(addprefix $(SRC_PATH),$(SOURCES))
OBJS = $(addprefix $(OBJ_PATH),$(SOURCES:.cu=.o))
DEPS = $(addprefix $(OBJ_PATH),$(SOURCES:.cu=.d))

### COLORS ###
NOC         = \033[0m
GREEN       = \033[1;32m
CYAN        = \033[1;36m

### RULES ###

all: lib tmp $(NAME)

lib:
	@echo "$(GREEN)Creating lib files$(NOC)"
	@make -C $(MLX)
	@make -C $(LIBFT)

tmp:
	@mkdir -p $(OBJ_DIRS)

$(NAME): $(OBJS)
	$(NVCC) $(NVCCFLAGS) $(INCLUDES) -L $(LIBFT) -L $(MLX) -o $@ $^ -l:libft.a -lmlx -lXext -lX11 -lm 
	@echo "$(GREEN)Project compiled succesfully$(NOC)"

$(OBJ_PATH)%.o: $(SRC_PATH)%.cu
	@$(NVCC) $(NVCCFLAGS) $(INCLUDES) -MMD -c $< -o $@
	@echo "$(CYAN)Creation of object file -> $(CYAN)$(notdir $@)... $(GREEN)[Done]$(NOC)"

clean:
	@echo "$(GREEN)Cleaning libraries files$(NOC)"
	@make clean -C $(LIBFT)
	@rm -rf $(OBJ_PATH)

fclean:
	@echo "$(GREEN)Cleaning all$(NOC)"
	@rm -rf $(OBJ_PATH)
	@rm -f $(NAME)
	@make clean -C $(MLX)
	@make fclean -C $(LIBFT)

re: fclean all

-include $(DEPS)

.PHONY: tmp, re, fclean, clean, run


