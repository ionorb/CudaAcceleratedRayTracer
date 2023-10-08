/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   memory.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yridgway <yridgway@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/01/30 15:34:04 by yridgway          #+#    #+#             */
/*   Updated: 2023/04/05 03:38:18 by yridgway         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minirt.h"

void	*ft_liberate(t_mem *mem, int type)
{
	t_mem	*prev;

	while (mem)
	{
		if (mem->ptr)
			cudaFree(mem->ptr);
		prev = mem;
		mem = mem->next;
		cudaFree(prev);
	}
	if (type == EXIT_ERROR)
		exit(1);
	else if (type == EXIT_OK)
		exit(0);
	return (NULL);
}

t_mem	*mem_addback(t_mem **mem, t_mem *newy)
{
	t_mem	*tmp;

	tmp = *mem;
	if (!newy)
		return (ft_memory(NULL, EXIT_ERROR), (t_mem*)NULL);
	if (!tmp)
		return (mem = &newy, *mem);
	while (tmp && tmp->next)
		tmp = tmp->next;
	tmp->next = newy;
	return (*mem);
}

t_mem	*mem_new(size_t size, void *thing)
{
	t_mem	*newy;
	char	*err;
	cudaError_t cudaErr;

	err = "Error: malloc failed\n";
	// newy = (t_mem*)malloc(sizeof(t_mem));
	cudaErr = cudaMallocManaged((void **)&newy, sizeof(t_mem));
	if (!newy)
	{
		printf("cudaErr: %s\n", cudaGetErrorString(cudaErr));
		return (ft_putstr_fd(err, 2), (t_mem*)NULL);
	}
	if (thing)
		newy->ptr = thing;
	else
	{
		cudaMallocManaged(&newy->ptr, size);
		// newy->ptr = malloc(size);
	}
	if (!newy->ptr)
	{
		ft_putstr_fd(err, 2);
		cudaFree(newy);
		newy = NULL;
		return (NULL);
	}
	newy->next = NULL;
	return (newy);
}

void	ft_close_fd(int *fd)
{
	if (*fd > 2)
	{
		close(*fd);
		*fd = -2;
	}
	ft_memory(fd, SAVE_FD);
}

void	*ft_memory(void *ptr, long long int size)
{
	static t_mem	*mem = NULL;
	t_mem			*newy;
	// static void		*mlx[3];
	static int		fd;

	if (size == MEM_SIZE)
		return (printf("mem size: %d\n", mem_size(mem)), (void*)NULL);
	if (size == FREE_ONE)
		return (ft_free_one(mem, ptr), (void*)NULL);
	if (ptr && size == ADD_TO_MEM)
		return (mem = mem_addback(&mem, mem_new(0, ptr)));
	if (size == EXIT_ERROR || size == EXIT_OK)
		return (ft_close_fd(&fd),
			mem = (t_mem*)ft_liberate(mem, size), (void*)NULL);
	// if (ptr && size == SAVE_MLX)
	// 	return (ft_save_mlx(ptr, &mlx[0], &mlx[1], &mlx[2]), (void*)NULL);
	if (ptr && size == SAVE_FD)
		return (fd = *(int *)ptr, (void*)NULL);
	newy = mem_new(size, NULL);
	mem = mem_addback(&mem, newy);
	return (newy->ptr);
}
