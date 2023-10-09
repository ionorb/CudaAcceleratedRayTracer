/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   paint.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gamoreno <gamoreno@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/21 22:24:35 by gamoreno          #+#    #+#             */
/*   Updated: 2023/04/07 18:23:52 by gamoreno         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../includes/minirt.h"

void	my_mlx_pixel_put(t_mrt *mrt, int x, int y, int color)
{
	char	*dst;

	// if (!mrt->save && x < BORDER)
		// color = diminish_color(color, 0.3);
	dst = mrt->addr + (y * mrt->sizel + x * (mrt->bpp / 8));
	*(unsigned int *)dst = color;
}

void __global__ ft_paint_device(t_mrt *mrt)
{
	// t_mrt	*mrt;
	int		i;
	int		j;
	int		color;

	int index = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;
	(void)index;
	(void)stride;
	// mrt = (t_mrt *)data;
	i = 0;
	printf("\nHELLO: %d\n", index);
	printf("mrt: %p\n", mrt);
	// mrt->ix = 1000;
	// mrt->iy = 1800;
	while (i < mrt->ix)
	{
		j = 0;
		// ft_percentage_bar(mrt);
		while (j < mrt->iy - 1)
		{
			color = get_pixel_color(mrt, i + 1, j + 1);
			my_mlx_pixel_put(mrt, i, j, color);
			j++;
		}
		i++;
	}
	// return (NULL);
}

void ft_paint_host(void *data)
{
	t_mrt	*mrt;
	int		i;
	int		j;
	int		color;

	mrt = (t_mrt *)data;
	i = 0;
	// printf("mrt: %p\n", mrt);
	// mrt->ix = 1000;
	// mrt->iy = 1800;
	while (i < mrt->ix)
	{
		j = 0;
		// ft_percentage_bar(mrt);
		while (j < mrt->iy - 1)
		{
			color = get_pixel_color(mrt, i + 1, j + 1);
			my_mlx_pixel_put(mrt, i, j, color);
			j++;
		}
		i++;
		printf("ix: %d / %d\r", i, mrt->ix);
	}
	// return (NULL);
}

void	pixel_calcul(t_mrt *mrt)
{
	int deviceId;
	int numberOfSMs;

	CUDA_CALL(cudaGetDevice(&deviceId));
	CUDA_CALL(cudaDeviceGetAttribute(&numberOfSMs, cudaDevAttrMultiProcessorCount, deviceId));
	
	size_t threadsPerBlock = 1;//256;
	size_t numberOfBlocks = 1;//32 * numberOfSMs;
	
	// t_mrt	*dat;
	// init_minirt(dat, "scenes/mirror_balls.rt", 1);
	// dat = ft_copy_mrt(mrt);
	// printf("\nHELLO\n");
	
	ft_paint_device<<<threadsPerBlock, numberOfBlocks>>>(mrt);
	CUDA_CALL(cudaGetLastError());
	// ft_paint_host(mrt);
	CUDA_CALL(cudaDeviceSynchronize());
	// int		i;

	// i = 0;
	// mrt->i = 0;
	// while (i < THRE#define CUDA_CALL(x) do { if((x) != cudaSuccess) { \
    printf("Error at %s:%d\n",__FILE__,__LINE__); \
    printf("%s\n",cudaGetErrorString(x)); \
    system("pause"); \
    return EXIT_FAILURE;}} while(0)ADS)
	// {
	// 	dat[i].i = i;
	// 	pthread_create(&mrt->threads[i], NULL, \
	// 	(void *)ft_paint, (void *)&dat[i]);
	// 	i++;
	// }
	// i = -1;
	// while (++i < THREADS)
	// 	pthread_join(mrt->threads[i], NULL);
	// if (mrt->first)
	// 	printf("\r[100%%]\n");
	// ft_free_mrt(dat, THREADS);
}
